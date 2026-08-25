-- Configuração da API do Stripe feita pela própria interface (aba
-- Configurações), sem depender de variáveis de ambiente do Railway.
-- Tabela singleton: sempre uma única linha com id = 1.
CREATE TABLE IF NOT EXISTS platform_settings (
  id INTEGER PRIMARY KEY DEFAULT 1,
  stripe_publishable_key TEXT,
  stripe_secret_key_encrypted BYTEA,
  stripe_webhook_secret_encrypted BYTEA,
  updated_by TEXT,
  updated_at TEXT,
  CONSTRAINT platform_settings_singleton CHECK (id = 1)
);
