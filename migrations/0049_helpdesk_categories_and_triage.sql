-- Help Desk Inteligente (Fase 2a): categorias/subcategorias configuráveis
-- pelo administrador e campos de triagem automática por IA nos chamados.

CREATE TABLE IF NOT EXISTS helpdesk_categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT true,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS helpdesk_subcategories (
  id TEXT PRIMARY KEY,
  category_id TEXT NOT NULL REFERENCES helpdesk_categories(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT helpdesk_subcategories_unique UNIQUE (category_id, name)
);

CREATE INDEX IF NOT EXISTS idx_helpdesk_subcategories_category ON helpdesk_subcategories(category_id);

-- Seed da taxonomia inicial pedida pelo cliente. gen_random_uuid() já é usado
-- em outras tabelas deste projeto (extensão pgcrypto habilitada por padrão
-- nos provedores gerenciados usados aqui); se não estiver disponível, o
-- valor abaixo cai para md5(random()) como já feito em outras migrations.
DO $$
DECLARE
  cat_id TEXT;
  seed_categories TEXT[] := ARRAY[
    'Fiscal', 'Financeiro', 'Contábil', 'Departamento Pessoal', 'RH', 'Cadastro',
    'NF-e', 'NFS-e', 'CT-e', 'Integrações', 'Usuários e Permissões', 'Relatórios',
    'Sistema/Infraestrutura', 'Erro/Bug', 'Solicitação de Melhoria', 'Dúvida', 'Outros'
  ];
  cat_name TEXT;
  idx INTEGER := 0;
BEGIN
  FOREACH cat_name IN ARRAY seed_categories LOOP
    idx := idx + 1;
    INSERT INTO helpdesk_categories(id, name, active, sort_order, created_at, updated_at)
    VALUES (md5(random()::text || clock_timestamp()::text), cat_name, true, idx, now()::text, now()::text)
    ON CONFLICT (name) DO NOTHING;
  END LOOP;

  SELECT id INTO cat_id FROM helpdesk_categories WHERE name = 'Fiscal';
  IF cat_id IS NOT NULL THEN
    idx := 0;
    FOREACH cat_name IN ARRAY ARRAY['NF-e', 'NFS-e', 'CT-e', 'ICMS', 'IPI', 'ICMS-ST', 'ISS', 'Obrigações acessórias', 'SPED'] LOOP
      idx := idx + 1;
      INSERT INTO helpdesk_subcategories(id, category_id, name, active, sort_order, created_at, updated_at)
      VALUES (md5(random()::text || clock_timestamp()::text), cat_id, cat_name, true, idx, now()::text, now()::text)
      ON CONFLICT (category_id, name) DO NOTHING;
    END LOOP;
  END IF;

  SELECT id INTO cat_id FROM helpdesk_categories WHERE name = 'Financeiro';
  IF cat_id IS NOT NULL THEN
    idx := 0;
    FOREACH cat_name IN ARRAY ARRAY['Contas a pagar', 'Contas a receber', 'DDA', 'Baixas', 'Boletos', 'Relatórios'] LOOP
      idx := idx + 1;
      INSERT INTO helpdesk_subcategories(id, category_id, name, active, sort_order, created_at, updated_at)
      VALUES (md5(random()::text || clock_timestamp()::text), cat_id, cat_name, true, idx, now()::text, now()::text)
      ON CONFLICT (category_id, name) DO NOTHING;
    END LOOP;
  END IF;
END $$;

-- Novos campos de triagem no chamado. A escala de prioridade passa de
-- baixa/media/alta/urgente para P1-P4 (mapeamento 1:1, mantendo o sentido).
ALTER TABLE support_tickets DROP CONSTRAINT IF EXISTS support_tickets_priority_check;
UPDATE support_tickets SET priority = CASE priority
  WHEN 'urgente' THEN 'P1' WHEN 'alta' THEN 'P2' WHEN 'media' THEN 'P3' WHEN 'baixa' THEN 'P4'
  ELSE priority END;
ALTER TABLE support_tickets ALTER COLUMN priority SET DEFAULT 'P3';
ALTER TABLE support_tickets ADD CONSTRAINT support_tickets_priority_check CHECK (priority IN ('P1', 'P2', 'P3', 'P4'));

ALTER TABLE support_tickets DROP CONSTRAINT IF EXISTS support_tickets_status_check;
ALTER TABLE support_tickets ADD CONSTRAINT support_tickets_status_check CHECK (status IN (
  'aberto', 'em_analise', 'aguardando_usuario', 'em_desenvolvimento', 'resolvido', 'encerrado', 'aguardando_info_ia'
));

ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS category_id TEXT REFERENCES helpdesk_categories(id);
ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS subcategory_id TEXT REFERENCES helpdesk_subcategories(id);
ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS priority_confirmed BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS priority_source TEXT;
ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS ai_triage_status TEXT NOT NULL DEFAULT 'pending';
ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS ai_triage_attempts INTEGER NOT NULL DEFAULT 0;
ALTER TABLE support_tickets ADD COLUMN IF NOT EXISTS ai_triage JSONB;
ALTER TABLE support_tickets DROP CONSTRAINT IF EXISTS support_tickets_ai_triage_status_check;
ALTER TABLE support_tickets ADD CONSTRAINT support_tickets_ai_triage_status_check CHECK (ai_triage_status IN ('pending', 'asking', 'completed', 'unavailable'));

CREATE INDEX IF NOT EXISTS idx_support_tickets_category_id ON support_tickets(category_id);
CREATE INDEX IF NOT EXISTS idx_support_tickets_subcategory_id ON support_tickets(subcategory_id);
