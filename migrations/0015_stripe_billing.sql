-- Integração com Stripe Checkout/Billing Portal (assinaturas pagas).
ALTER TABLE access_plans ADD COLUMN IF NOT EXISTS stripe_product_id TEXT;
ALTER TABLE access_plans ADD COLUMN IF NOT EXISTS stripe_price_id_monthly TEXT;
ALTER TABLE access_plans ADD COLUMN IF NOT EXISTS stripe_price_id_yearly TEXT;

ALTER TABLE subscriptions DROP CONSTRAINT IF EXISTS subscriptions_status_check;
ALTER TABLE subscriptions ADD CONSTRAINT subscriptions_status_check
  CHECK (status IN ('ATIVA', 'TESTE', 'PENDENTE', 'VENCIDA', 'CANCELADA', 'BLOQUEADA',
                     'AGUARDANDO_PAGAMENTO', 'INADIMPLENTE'));

ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS stripe_customer_id TEXT;
ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS stripe_subscription_id TEXT UNIQUE;
ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS stripe_checkout_session_id TEXT;
ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS stripe_price_id TEXT;
ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS current_period_start TEXT;
ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS current_period_end TEXT;
ALTER TABLE subscriptions ADD COLUMN IF NOT EXISTS cancel_at_period_end BOOLEAN NOT NULL DEFAULT FALSE;

CREATE INDEX IF NOT EXISTS idx_subscriptions_stripe_customer ON subscriptions(stripe_customer_id);

CREATE TABLE IF NOT EXISTS payments (
  id TEXT PRIMARY KEY,
  empresa_id TEXT NOT NULL REFERENCES companies(id),
  subscription_id TEXT REFERENCES subscriptions(id),
  stripe_payment_intent_id TEXT,
  stripe_invoice_id TEXT,
  amount DOUBLE PRECISION NOT NULL,
  currency TEXT NOT NULL DEFAULT 'brl',
  status TEXT NOT NULL,
  payment_date TEXT,
  criado_em TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_payments_empresa ON payments(empresa_id, payment_date DESC);

-- Garante que o mesmo evento do Stripe processado mais de uma vez (reentrega
-- de webhook) nunca duplique efeitos colaterais (seção 22 da especificação).
CREATE TABLE IF NOT EXISTS webhook_events (
  id TEXT PRIMARY KEY,
  provider TEXT NOT NULL DEFAULT 'stripe',
  event_type TEXT NOT NULL,
  processed_at TEXT NOT NULL
);
