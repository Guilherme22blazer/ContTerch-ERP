-- Painel de Acompanhamento Contábil: status mensal do processo contábil de
-- cada cliente (recebimento de documentos, escrituração, apuração de
-- impostos, fechamento e envio de obrigações acessórias). Os clientes em si
-- não têm tabela própria (vivem no JSON de app_state.payload.clients), por
-- isso client_id não tem FK — o nome é salvo junto para exibição mesmo que
-- o cliente seja removido depois da base.

CREATE TABLE IF NOT EXISTS acompanhamento_contabil (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  client_id TEXT NOT NULL,
  client_name TEXT NOT NULL,
  competencia TEXT NOT NULL,
  documentos_status TEXT NOT NULL DEFAULT 'pendente',
  escrituracao_status TEXT NOT NULL DEFAULT 'pendente',
  apuracao_status TEXT NOT NULL DEFAULT 'pendente',
  fechamento_status TEXT NOT NULL DEFAULT 'pendente',
  obrigacoes_status TEXT NOT NULL DEFAULT 'pendente',
  responsavel TEXT,
  observacoes TEXT,
  updated_by TEXT,
  updated_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  CONSTRAINT acompanhamento_contabil_competencia_check CHECK (competencia ~ '^\d{4}-\d{2}$'),
  CONSTRAINT acompanhamento_contabil_unique UNIQUE (company_id, client_id, competencia)
);

CREATE INDEX IF NOT EXISTS idx_acompanhamento_contabil_company_competencia
  ON acompanhamento_contabil(company_id, competencia);
