-- Central de Suporte Inteligente (Fase 1): chamados de suporte (dúvida,
-- bug, melhoria, chamado geral), histórico de mensagens por chamado
-- (usuário, IA, agente humano ou sistema) e anexos (prints/arquivos).
-- Contadores por ano geram o número de protocolo (ex.: CT-2026-000125) de
-- forma atômica, sem depender de COUNT(*) (evita colisão sob concorrência).

CREATE TABLE IF NOT EXISTS support_ticket_counters (
  year INTEGER PRIMARY KEY,
  last_value INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS support_tickets (
  id TEXT PRIMARY KEY,
  protocol TEXT NOT NULL UNIQUE,
  company_id TEXT NOT NULL REFERENCES companies(id),
  requester_email TEXT NOT NULL,
  requester_name TEXT NOT NULL,
  category TEXT NOT NULL,
  module_key TEXT,
  priority TEXT NOT NULL DEFAULT 'media',
  status TEXT NOT NULL DEFAULT 'aberto',
  subject TEXT NOT NULL,
  description TEXT NOT NULL,
  error_message TEXT,
  steps_to_reproduce TEXT,
  expected_benefit TEXT,
  page_context TEXT,
  browser_info TEXT,
  ai_summary TEXT,
  assigned_to TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT support_tickets_category_check CHECK (category IN ('duvida', 'bug', 'melhoria', 'chamado')),
  CONSTRAINT support_tickets_priority_check CHECK (priority IN ('baixa', 'media', 'alta', 'urgente')),
  CONSTRAINT support_tickets_status_check CHECK (status IN ('aberto', 'em_analise', 'aguardando_usuario', 'em_desenvolvimento', 'resolvido', 'encerrado'))
);

CREATE INDEX IF NOT EXISTS idx_support_tickets_company ON support_tickets(company_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_support_tickets_requester ON support_tickets(requester_email, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_support_tickets_status ON support_tickets(status);
CREATE INDEX IF NOT EXISTS idx_support_tickets_category ON support_tickets(category);

CREATE TABLE IF NOT EXISTS support_ticket_messages (
  id TEXT PRIMARY KEY,
  ticket_id TEXT NOT NULL REFERENCES support_tickets(id) ON DELETE CASCADE,
  author_type TEXT NOT NULL,
  author_name TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TEXT NOT NULL,
  CONSTRAINT support_ticket_messages_author_check CHECK (author_type IN ('user', 'ai', 'agent', 'system'))
);

CREATE INDEX IF NOT EXISTS idx_support_ticket_messages_ticket ON support_ticket_messages(ticket_id, created_at);

CREATE TABLE IF NOT EXISTS support_ticket_attachments (
  id TEXT PRIMARY KEY,
  ticket_id TEXT NOT NULL REFERENCES support_tickets(id) ON DELETE CASCADE,
  filename TEXT NOT NULL,
  content_type TEXT NOT NULL,
  size_bytes INTEGER NOT NULL,
  data BYTEA NOT NULL,
  created_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_support_ticket_attachments_ticket ON support_ticket_attachments(ticket_id);
