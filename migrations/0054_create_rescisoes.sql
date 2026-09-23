-- Rescisão como workflow (RH & Departamento Pessoal): liga o colaborador ao
-- motor de cálculo que já existia na calculadora de Verbas Rescisórias,
-- guardando os dados usados no cálculo e o resultado completo (memória de
-- cálculo) como snapshot em JSONB — a legislação usada na data do cálculo
-- fica preservada mesmo que a tabela de parâmetros mude depois.

CREATE TABLE IF NOT EXISTS rescisoes (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  colaborador_id TEXT NOT NULL REFERENCES colaboradores(id) ON DELETE CASCADE,
  motivo TEXT NOT NULL,
  data_desligamento TEXT NOT NULL,
  aviso_previo_tipo TEXT NOT NULL DEFAULT 'indenizado',
  status TEXT NOT NULL DEFAULT 'calculada',
  valor_bruto NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_descontos NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_liquido NUMERIC(12,2) NOT NULL DEFAULT 0,
  fgts_deposito NUMERIC(12,2) NOT NULL DEFAULT 0,
  fgts_multa NUMERIC(12,2) NOT NULL DEFAULT 0,
  dados_calculo JSONB NOT NULL DEFAULT '{}',
  resultado_calculo JSONB NOT NULL DEFAULT '{}',
  observacoes TEXT,
  created_by TEXT,
  updated_by TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT rescisoes_status_check CHECK (status IN ('calculada', 'aprovada', 'paga', 'arquivada')),
  CONSTRAINT rescisoes_aviso_check CHECK (aviso_previo_tipo IN ('trabalhado', 'indenizado', 'dispensado', 'nao-cumprido'))
);

CREATE INDEX IF NOT EXISTS idx_rescisoes_colaborador ON rescisoes(colaborador_id);
CREATE INDEX IF NOT EXISTS idx_rescisoes_company_status ON rescisoes(company_id, status);
