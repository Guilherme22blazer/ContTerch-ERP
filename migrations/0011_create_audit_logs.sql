CREATE TABLE IF NOT EXISTS audit_logs (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES users(id) ON DELETE SET NULL,
  empresa_id TEXT REFERENCES companies(id),
  modulo TEXT,
  acao TEXT NOT NULL,
  tabela TEXT,
  registro_id TEXT,
  dados_anteriores TEXT,
  dados_novos TEXT,
  ip TEXT,
  data_hora TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_audit_logs_empresa_time ON audit_logs(empresa_id, data_hora DESC);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user_time ON audit_logs(user_id, data_hora DESC);
