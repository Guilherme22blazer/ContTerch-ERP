-- "app_state" era uma linha única (id=1) com os dados de toda a instalação.
-- Passa a ser uma linha por empresa, chaveada por company_id, eliminando o
-- compartilhamento global de dados entre empresas (multi-tenant).
ALTER TABLE app_state ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);
ALTER TABLE app_state DROP CONSTRAINT IF EXISTS app_state_pkey;
ALTER TABLE app_state DROP COLUMN IF EXISTS id;
ALTER TABLE app_state ALTER COLUMN company_id SET NOT NULL;
ALTER TABLE app_state ADD PRIMARY KEY (company_id);
