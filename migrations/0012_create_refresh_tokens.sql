CREATE TABLE IF NOT EXISTS refresh_tokens (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL REFERENCES users(email) ON DELETE CASCADE,
  token_hash TEXT NOT NULL UNIQUE,
  session_token TEXT,
  created_at BIGINT NOT NULL,
  expires_at BIGINT NOT NULL,
  revoked_at BIGINT
);

CREATE INDEX IF NOT EXISTS idx_refresh_tokens_email ON refresh_tokens(email, expires_at DESC);
