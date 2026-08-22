-- Exceções individuais de permissão (sobrepõem o que o perfil/role concede).
-- Não confundir com "user_sefaz_permissions" (permissões fiscais legadas).
CREATE TABLE IF NOT EXISTS user_permissions (
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  permission_id TEXT NOT NULL REFERENCES permissions(id),
  allowed BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY(user_id, permission_id)
);
