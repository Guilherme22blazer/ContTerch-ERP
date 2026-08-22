CREATE TABLE IF NOT EXISTS login_logs (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES users(id) ON DELETE SET NULL,
  email TEXT NOT NULL,
  empresa_id TEXT REFERENCES companies(id),
  data_hora TEXT NOT NULL,
  ip TEXT,
  dispositivo TEXT,
  navegador TEXT,
  sucesso BOOLEAN NOT NULL,
  motivo_falha TEXT
);

CREATE INDEX IF NOT EXISTS idx_login_logs_email_time ON login_logs(email, data_hora DESC);
CREATE INDEX IF NOT EXISTS idx_login_logs_empresa_time ON login_logs(empresa_id, data_hora DESC);
