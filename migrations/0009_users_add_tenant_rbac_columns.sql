ALTER TABLE users ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);
ALTER TABLE users ADD COLUMN IF NOT EXISTS perfil_id TEXT REFERENCES roles(id);
ALTER TABLE users ADD COLUMN IF NOT EXISTS sobrenome TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS primeiro_acesso BOOLEAN NOT NULL DEFAULT FALSE;
-- 'pbkdf2' (legado, compatível com hashes existentes) ou 'bcrypt' (novo padrão).
ALTER TABLE users ADD COLUMN IF NOT EXISTS password_algo TEXT NOT NULL DEFAULT 'pbkdf2';

CREATE INDEX IF NOT EXISTS idx_users_company ON users(company_id);
CREATE INDEX IF NOT EXISTS idx_users_perfil ON users(perfil_id);
