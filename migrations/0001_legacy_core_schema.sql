-- Esquema principal migrado do SQLite (simplescalc.db) para PostgreSQL.
-- Tipos escolhidos para preservar o comportamento do código Python existente:
--   * BLOB -> BYTEA
--   * REAL -> DOUBLE PRECISION (evita que o psycopg devolva Decimal em vez de float)
--   * flags 0/1 -> INTEGER (o código compara "= 1" e faz bool(row["campo"]))
--   * carimbos de data/hora -> TEXT (gerados em Python via local_now()) ou BIGINT (epoch)

CREATE TABLE IF NOT EXISTS users (
  email TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  role TEXT NOT NULL,
  salt TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  active INTEGER NOT NULL DEFAULT 1,
  billing_cycle TEXT,
  subscription_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  monitoring_start TEXT,
  monitoring_end TEXT,
  last_login_at TEXT,
  previous_login_at TEXT,
  profile_photo_encrypted BYTEA,
  profile_photo_mime TEXT,
  profile_photo_updated_at TEXT,
  id TEXT,
  document TEXT,
  phone TEXT,
  company TEXT,
  company_document TEXT,
  job_title TEXT,
  department TEXT,
  login TEXT,
  status TEXT NOT NULL DEFAULT 'Ativo',
  plan_id TEXT,
  notes TEXT,
  created_at TEXT,
  updated_at TEXT,
  created_by TEXT,
  updated_by TEXT,
  last_login_ip TEXT,
  login_attempts INTEGER NOT NULL DEFAULT 0,
  blocked_at TEXT
);

-- Restrição (não índice parcial) para poder ser referenciada por FK (ex.: user_permissions.user_id).
ALTER TABLE users ADD CONSTRAINT users_id_unique UNIQUE (id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_login ON users(login) WHERE login IS NOT NULL AND login != '';
CREATE INDEX IF NOT EXISTS idx_users_document_lookup ON users(document);
CREATE INDEX IF NOT EXISTS idx_users_company_document_lookup ON users(company_document);
CREATE INDEX IF NOT EXISTS idx_users_status_end ON users(status, monitoring_end);
CREATE INDEX IF NOT EXISTS idx_users_plan ON users(plan_id);

CREATE TABLE IF NOT EXISTS sessions (
  token TEXT PRIMARY KEY,
  email TEXT NOT NULL REFERENCES users(email),
  created_at BIGINT NOT NULL,
  expires_at BIGINT NOT NULL
);

-- Substitui o antigo "app_state" (linha única id=1, dados globais de toda a
-- instalação) por um estado por empresa. Ver migration 0014 para a coluna
-- company_id / chave primária definitiva, criada depois que a tabela
-- "companies" existir.
CREATE TABLE IF NOT EXISTS app_state (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  payload TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  updated_by TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS server_audit (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at TEXT NOT NULL,
  email TEXT NOT NULL,
  action TEXT NOT NULL,
  detail TEXT
);

CREATE TABLE IF NOT EXISTS fiscal_certificates (
  id TEXT PRIMARY KEY,
  company TEXT NOT NULL,
  branch TEXT,
  document TEXT,
  holder TEXT NOT NULL,
  issuer TEXT NOT NULL,
  serial TEXT NOT NULL,
  valid_from TEXT NOT NULL,
  valid_until TEXT NOT NULL,
  environment TEXT NOT NULL,
  state_code TEXT,
  pfx_encrypted BYTEA NOT NULL,
  password_encrypted BYTEA,
  save_password INTEGER NOT NULL DEFAULT 0,
  created_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  active INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS fiscal_queries (
  id TEXT PRIMARY KEY,
  access_key TEXT NOT NULL,
  model TEXT NOT NULL,
  company TEXT,
  certificate_id TEXT REFERENCES fiscal_certificates(id),
  environment TEXT NOT NULL,
  status TEXT NOT NULL,
  risk_level TEXT NOT NULL,
  official_code TEXT,
  source_name TEXT NOT NULL,
  source_url TEXT NOT NULL,
  result_encrypted BYTEA NOT NULL,
  xml_encrypted BYTEA,
  xml_filename TEXT,
  xml_sha256 TEXT,
  record_origin TEXT NOT NULL DEFAULT 'official_query',
  import_batch_id TEXT,
  consulted_by TEXT NOT NULL,
  consulted_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_fiscal_queries_date ON fiscal_queries(consulted_at DESC);
CREATE INDEX IF NOT EXISTS idx_fiscal_queries_key ON fiscal_queries(access_key);

-- Renomeado de "user_permissions": exceções de permissões fiscais (SEFAZ_PERMISSIONS)
-- por usuário. O nome "user_permissions" passa a ser usado pela nova tabela
-- RBAC genérica (permissão por módulo/ação) criada na migration 0007.
CREATE TABLE IF NOT EXISTS user_sefaz_permissions (
  email TEXT NOT NULL REFERENCES users(email),
  permission TEXT NOT NULL,
  allowed INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY(email, permission)
);

CREATE TABLE IF NOT EXISTS access_plans (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  monthly_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  annual_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  max_users INTEGER NOT NULL DEFAULT 1,
  trial_days INTEGER NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'Ativo',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS plan_modules (
  plan_id TEXT NOT NULL REFERENCES access_plans(id),
  module_key TEXT NOT NULL,
  PRIMARY KEY(plan_id, module_key)
);

CREATE TABLE IF NOT EXISTS user_modules (
  email TEXT NOT NULL REFERENCES users(email),
  module_key TEXT NOT NULL,
  allowed INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY(email, module_key)
);

CREATE TABLE IF NOT EXISTS access_audit (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at TEXT NOT NULL,
  administrator_email TEXT NOT NULL,
  affected_email TEXT,
  action TEXT NOT NULL,
  previous_value TEXT,
  new_value TEXT,
  ip_address TEXT
);

CREATE INDEX IF NOT EXISTS idx_access_audit_user_date ON access_audit(affected_email, created_at DESC);

CREATE TABLE IF NOT EXISTS password_reset_tokens (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL REFERENCES users(email) ON DELETE CASCADE,
  token_hash TEXT NOT NULL UNIQUE,
  created_at BIGINT NOT NULL,
  expires_at BIGINT NOT NULL,
  used_at BIGINT,
  ip_address TEXT
);

CREATE INDEX IF NOT EXISTS idx_password_reset_token_hash ON password_reset_tokens(token_hash);
CREATE INDEX IF NOT EXISTS idx_password_reset_email_expiry ON password_reset_tokens(email, expires_at DESC);

CREATE TABLE IF NOT EXISTS password_reset_attempts (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email TEXT NOT NULL,
  ip_address TEXT,
  attempted_at BIGINT NOT NULL,
  successful INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_password_reset_attempt_email_time ON password_reset_attempts(email, attempted_at DESC);
CREATE INDEX IF NOT EXISTS idx_password_reset_attempt_ip_time ON password_reset_attempts(ip_address, attempted_at DESC);

CREATE TABLE IF NOT EXISTS distributed_documents (
  id TEXT PRIMARY KEY,
  certificate_id TEXT NOT NULL REFERENCES fiscal_certificates(id),
  environment TEXT NOT NULL,
  state_code TEXT NOT NULL,
  nsu TEXT NOT NULL,
  schema_name TEXT,
  document_type TEXT,
  access_key TEXT,
  direction TEXT,
  status TEXT,
  result_encrypted BYTEA NOT NULL,
  xml_encrypted BYTEA NOT NULL,
  synced_by TEXT NOT NULL,
  received_at TEXT NOT NULL,
  UNIQUE(certificate_id, environment, nsu)
);

CREATE INDEX IF NOT EXISTS idx_distributed_documents_date ON distributed_documents(received_at DESC);
CREATE INDEX IF NOT EXISTS idx_distributed_documents_key ON distributed_documents(access_key);

CREATE TABLE IF NOT EXISTS distribution_state (
  certificate_id TEXT NOT NULL REFERENCES fiscal_certificates(id),
  environment TEXT NOT NULL,
  state_code TEXT NOT NULL,
  last_nsu TEXT NOT NULL DEFAULT '000000000000000',
  max_nsu TEXT NOT NULL DEFAULT '000000000000000',
  official_code TEXT,
  motive TEXT,
  updated_at TEXT NOT NULL,
  PRIMARY KEY(certificate_id, environment, state_code)
);

CREATE TABLE IF NOT EXISTS nfse_monthly_imports (
  id TEXT PRIMARY KEY,
  certificate_id TEXT NOT NULL REFERENCES fiscal_certificates(id),
  environment TEXT NOT NULL,
  month TEXT NOT NULL,
  source_filename TEXT NOT NULL,
  source_sha256 TEXT NOT NULL,
  source_documents INTEGER NOT NULL,
  imported_documents INTEGER NOT NULL,
  duplicate_documents INTEGER NOT NULL,
  cancellation_events INTEGER NOT NULL,
  ignored_documents INTEGER NOT NULL,
  error_count INTEGER NOT NULL,
  is_complete INTEGER NOT NULL DEFAULT 0,
  imported_by TEXT NOT NULL,
  imported_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_nfse_monthly_imports_lookup ON nfse_monthly_imports(certificate_id, environment, month, imported_at DESC);

CREATE TABLE IF NOT EXISTS system_migrations (
  migration_key TEXT PRIMARY KEY,
  applied_at TEXT NOT NULL
);
