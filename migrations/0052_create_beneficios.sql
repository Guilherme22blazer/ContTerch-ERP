-- Benefícios (RH & Departamento Pessoal): vale-transporte, vale-refeição,
-- vale-alimentação, plano de saúde/odontológico, seguro, auxílios e
-- benefícios personalizados, atribuídos a um colaborador. Cada linha é uma
-- concessão de benefício com o valor total, o desconto do colaborador e o
-- custo assumido pela empresa (valor_beneficio - valor_desconto_colaborador).

CREATE TABLE IF NOT EXISTS beneficios (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  colaborador_id TEXT NOT NULL REFERENCES colaboradores(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL,
  descricao TEXT,
  valor_beneficio NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_desconto_colaborador NUMERIC(12,2) NOT NULL DEFAULT 0,
  valor_custo_empresa NUMERIC(12,2) NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'ativo',
  data_inicio TEXT NOT NULL,
  data_fim TEXT,
  observacoes TEXT,
  created_by TEXT,
  updated_by TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT beneficios_tipo_check CHECK (tipo IN (
    'vale_transporte', 'vale_refeicao', 'vale_alimentacao', 'plano_saude',
    'plano_odontologico', 'seguro_vida', 'auxilio_creche', 'auxilio_educacao', 'outro'
  )),
  CONSTRAINT beneficios_status_check CHECK (status IN ('ativo', 'inativo'))
);

CREATE INDEX IF NOT EXISTS idx_beneficios_colaborador ON beneficios(colaborador_id);
CREATE INDEX IF NOT EXISTS idx_beneficios_company_status ON beneficios(company_id, status);
