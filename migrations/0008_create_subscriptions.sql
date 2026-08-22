CREATE TABLE IF NOT EXISTS subscriptions (
  id TEXT PRIMARY KEY,
  empresa_id TEXT NOT NULL REFERENCES companies(id),
  plano_id TEXT NOT NULL REFERENCES access_plans(id),
  data_inicio TEXT NOT NULL,
  data_fim TEXT,
  status TEXT NOT NULL DEFAULT 'ATIVA'
    CHECK (status IN ('ATIVA', 'TESTE', 'PENDENTE', 'VENCIDA', 'CANCELADA', 'BLOQUEADA')),
  periodicidade TEXT NOT NULL DEFAULT 'MENSAL' CHECK (periodicidade IN ('MENSAL', 'ANUAL')),
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_subscriptions_empresa ON subscriptions(empresa_id, status);
