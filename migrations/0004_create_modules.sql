-- Catálogo de módulos. As linhas são semeadas em Python a partir do dicionário
-- ERP_MODULES (fonte única de verdade, já usado pelo restante do sistema),
-- para nunca haver divergência entre o catálogo do banco e o do código.
CREATE TABLE IF NOT EXISTS modules (
  id TEXT PRIMARY KEY,
  codigo TEXT NOT NULL UNIQUE,
  nome TEXT NOT NULL,
  descricao TEXT,
  rota TEXT,
  icone TEXT,
  ordem INTEGER NOT NULL DEFAULT 0,
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);
