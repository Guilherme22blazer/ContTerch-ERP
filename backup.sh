#!/bin/sh
# Backup do PostgreSQL + chave de criptografia.
#
# Funciona nos dois cenários:
#   1. Postgres auto-hospedado pelo docker-compose.yml deste projeto (serviço
#      "postgres") — roda "docker compose exec", não precisa de pg_dump local.
#   2. Provedor externo (Supabase/Neon/Railway/RDS) — usa "pg_dump" local
#      contra DATABASE_URL (requer o pacote postgresql-client instalado).
#
# Uso:
#   ./backup.sh                              # detecta o serviço "postgres" do compose
#   DATABASE_URL=postgresql://... ./backup.sh # força backup via pg_dump local
#
# Recomenda-se agendar via cron (ex.: diariamente) e manter uma política de
# retenção (ex.: apagar backups com mais de 30 dias) — ver exemplo ao final.
set -eu

STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="backups/$STAMP"
mkdir -p "$DEST"

if [ -z "${DATABASE_URL:-}" ] && docker compose ps postgres >/dev/null 2>&1; then
  docker compose exec -T postgres pg_dump -U conttech --format=custom -d conttech > "$DEST/database.dump"
  echo "Para restaurar: docker compose exec -T postgres pg_restore --clean --if-exists -U conttech -d conttech < $DEST/database.dump"
else
  : "${DATABASE_URL:?defina DATABASE_URL, ou rode este script na pasta com o docker-compose.yml usando o Postgres auto-hospedado}"
  pg_dump "$DATABASE_URL" --format=custom --file="$DEST/database.dump"
  echo "Para restaurar: pg_restore --clean --if-exists -d \"\$DATABASE_URL\" $DEST/database.dump"
fi

if [ -f "app/data/.gestao-fiscal.key" ]; then
  cp "app/data/.gestao-fiscal.key" "$DEST/.gestao-fiscal.key"
fi

echo "Backup concluído em $DEST"

# Exemplo de retenção (mantém os últimos 30 backups):
# ls -1dt backups/*/ | tail -n +31 | xargs -r rm -rf
