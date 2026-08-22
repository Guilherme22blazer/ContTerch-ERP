CREATE TABLE IF NOT EXISTS companies (
  id TEXT PRIMARY KEY,
  razao_social TEXT NOT NULL,
  nome_fantasia TEXT,
  cnpj TEXT UNIQUE,
  email TEXT,
  telefone TEXT,
  status TEXT NOT NULL DEFAULT 'ATIVA',
  plano_id TEXT REFERENCES access_plans(id),
  data_inicio TEXT,
  data_vencimento TEXT,
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_companies_status ON companies(status);
CREATE INDEX IF NOT EXISTS idx_companies_cnpj ON companies(cnpj);
