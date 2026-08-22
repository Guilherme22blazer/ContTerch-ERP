-- Permissões granulares por módulo x ação (visualizar, cadastrar, editar,
-- excluir, aprovar, exportar, importar, administrar). Semeadas em Python.
CREATE TABLE IF NOT EXISTS permissions (
  id TEXT PRIMARY KEY,
  codigo TEXT NOT NULL UNIQUE,
  nome TEXT NOT NULL,
  descricao TEXT,
  modulo_id TEXT NOT NULL REFERENCES modules(id)
);

CREATE INDEX IF NOT EXISTS idx_permissions_modulo ON permissions(modulo_id);
