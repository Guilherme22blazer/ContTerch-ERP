-- Cadastro de Colaboradores (RH & Departamento Pessoal), fase de fundação do
-- módulo de RH/DP. Assim como acompanhamento_contabil (migration 0047), o
-- "cliente" (empresa gerida pelo escritório) não tem tabela própria — vive no
-- JSON de app_state.payload.clients — por isso client_id não tem FK; o nome é
-- salvo junto (client_name) para exibição mesmo que o cliente seja removido
-- depois da base. Dependentes ficam em uma coluna JSONB (array de objetos),
-- suficiente para esta fase; pode ser normalizado em tabela própria depois se
-- for necessário consultar dependentes entre colaboradores/clientes.

CREATE TABLE IF NOT EXISTS colaboradores (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  client_id TEXT NOT NULL,
  client_name TEXT NOT NULL,
  matricula TEXT,
  status TEXT NOT NULL DEFAULT 'ativo',

  nome_completo TEXT NOT NULL,
  nome_social TEXT,
  cpf TEXT NOT NULL,
  rg TEXT,
  data_nascimento TEXT,
  sexo TEXT,
  estado_civil TEXT,
  nacionalidade TEXT,
  naturalidade TEXT,
  endereco_logradouro TEXT,
  endereco_numero TEXT,
  endereco_complemento TEXT,
  endereco_bairro TEXT,
  endereco_cidade TEXT,
  endereco_uf TEXT,
  endereco_cep TEXT,
  telefone TEXT,
  email TEXT,
  banco_nome TEXT,
  banco_agencia TEXT,
  banco_conta TEXT,
  banco_tipo_conta TEXT,
  pix_chave TEXT,
  pis_pasep TEXT,
  ctps_numero TEXT,
  ctps_serie TEXT,
  cnh_numero TEXT,
  cnh_categoria TEXT,

  departamento TEXT,
  setor TEXT,
  cargo TEXT,
  funcao TEXT,
  cbo TEXT,
  centro_custo TEXT,
  gestor_nome TEXT,
  data_admissao TEXT,
  data_desligamento TEXT,
  motivo_desligamento TEXT,
  tipo_contrato TEXT,
  regime_trabalho TEXT,
  jornada TEXT,
  escala TEXT,
  salario NUMERIC(12,2),
  categoria_profissional TEXT,
  sindicato TEXT,
  convencao_coletiva TEXT,
  data_base TEXT,

  dependentes JSONB NOT NULL DEFAULT '[]',
  notas TEXT,

  created_by TEXT,
  updated_by TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,

  CONSTRAINT colaboradores_status_check CHECK (status IN ('ativo', 'afastado', 'desligado')),
  CONSTRAINT colaboradores_cpf_unique UNIQUE (company_id, client_id, cpf)
);

CREATE INDEX IF NOT EXISTS idx_colaboradores_company_client ON colaboradores(company_id, client_id);
CREATE INDEX IF NOT EXISTS idx_colaboradores_company_status ON colaboradores(company_id, client_id, status);
