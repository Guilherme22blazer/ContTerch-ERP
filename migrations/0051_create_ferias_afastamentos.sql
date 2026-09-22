-- Férias e Afastamentos (RH & Departamento Pessoal), construídos sobre a
-- base de colaboradores criada na migration 0050. Cada registro pertence a
-- um colaborador (FK real, já que colaboradores agora tem tabela própria) e
-- ao mesmo tenant (company_id) para reforçar o isolamento multi-empresa.

CREATE TABLE IF NOT EXISTS ferias (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  colaborador_id TEXT NOT NULL REFERENCES colaboradores(id) ON DELETE CASCADE,
  periodo_aquisitivo_inicio TEXT NOT NULL,
  periodo_aquisitivo_fim TEXT NOT NULL,
  periodo_concessivo_fim TEXT NOT NULL,
  data_inicio_gozo TEXT,
  dias_gozo INTEGER NOT NULL DEFAULT 30,
  dias_abono INTEGER NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'programada',
  valor_base NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_bruto NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_inss NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_irrf NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_liquido NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_abono NUMERIC(12,2) NOT NULL DEFAULT 0,
  observacoes TEXT,
  created_by TEXT,
  updated_by TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT ferias_status_check CHECK (status IN ('programada', 'aprovada', 'em_gozo', 'concluida', 'cancelada')),
  CONSTRAINT ferias_dias_gozo_check CHECK (dias_gozo IN (30, 20, 15, 10, 5)),
  CONSTRAINT ferias_dias_abono_check CHECK (dias_abono >= 0 AND dias_abono <= 10)
);

CREATE INDEX IF NOT EXISTS idx_ferias_colaborador ON ferias(colaborador_id);
CREATE INDEX IF NOT EXISTS idx_ferias_company_status ON ferias(company_id, status);

CREATE TABLE IF NOT EXISTS afastamentos (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  colaborador_id TEXT NOT NULL REFERENCES colaboradores(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL,
  data_inicio TEXT NOT NULL,
  data_fim TEXT,
  documento_referencia TEXT,
  motivo TEXT,
  status TEXT NOT NULL DEFAULT 'em_andamento',
  created_by TEXT,
  updated_by TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT afastamentos_tipo_check CHECK (tipo IN ('doenca', 'acidente_trabalho', 'licenca_maternidade', 'licenca_paternidade', 'licenca_nao_remunerada', 'outro')),
  CONSTRAINT afastamentos_status_check CHECK (status IN ('em_andamento', 'encerrado'))
);

CREATE INDEX IF NOT EXISTS idx_afastamentos_colaborador ON afastamentos(colaborador_id);
CREATE INDEX IF NOT EXISTS idx_afastamentos_company_status ON afastamentos(company_id, status);
