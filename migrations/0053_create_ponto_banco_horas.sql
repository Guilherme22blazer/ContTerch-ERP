-- Ponto Eletrônico e Banco de Horas (RH & Departamento Pessoal).
-- Cada registro de ponto é um dia trabalhado (ou não) de um colaborador,
-- com os 4 horários padrão (entrada/saída do intervalo/saída final). O saldo
-- do banco de horas é a soma dos saldos diários aprovados mais os ajustes
-- manuais lançados em banco_horas_ajustes (compensações e acordos).

CREATE TABLE IF NOT EXISTS ponto_registros (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  colaborador_id TEXT NOT NULL REFERENCES colaboradores(id) ON DELETE CASCADE,
  data TEXT NOT NULL,
  tipo_dia TEXT NOT NULL DEFAULT 'normal',
  entrada1 TEXT,
  saida1 TEXT,
  entrada2 TEXT,
  saida2 TEXT,
  trabalho_noturno BOOLEAN NOT NULL DEFAULT false,
  horas_esperadas NUMERIC(5,2) NOT NULL DEFAULT 8,
  horas_trabalhadas NUMERIC(5,2) NOT NULL DEFAULT 0,
  saldo_dia NUMERIC(5,2) NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'pendente',
  observacoes TEXT,
  created_by TEXT,
  updated_by TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT ponto_registros_tipo_check CHECK (tipo_dia IN ('normal', 'feriado_trabalhado', 'falta', 'falta_justificada', 'folga', 'atestado')),
  CONSTRAINT ponto_registros_status_check CHECK (status IN ('pendente', 'aprovado')),
  CONSTRAINT ponto_registros_unique UNIQUE (colaborador_id, data)
);

CREATE INDEX IF NOT EXISTS idx_ponto_registros_colaborador ON ponto_registros(colaborador_id, data);
CREATE INDEX IF NOT EXISTS idx_ponto_registros_company_status ON ponto_registros(company_id, status);

CREATE TABLE IF NOT EXISTS banco_horas_ajustes (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  colaborador_id TEXT NOT NULL REFERENCES colaboradores(id) ON DELETE CASCADE,
  data TEXT NOT NULL,
  tipo TEXT NOT NULL,
  horas NUMERIC(6,2) NOT NULL,
  motivo TEXT,
  created_by TEXT,
  created_at TEXT NOT NULL,
  CONSTRAINT banco_horas_ajustes_tipo_check CHECK (tipo IN ('credito', 'debito')),
  CONSTRAINT banco_horas_ajustes_horas_check CHECK (horas > 0)
);

CREATE INDEX IF NOT EXISTS idx_banco_horas_ajustes_colaborador ON banco_horas_ajustes(colaborador_id);
