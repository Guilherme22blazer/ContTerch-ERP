#!/bin/sh
# Backup do PostgreSQL em nuvem (DATABASE_URL) + chave de criptografia.
#
# Requer o cliente "pg_dump" (pacote postgresql-client) instalado onde este
# script roda, e a variável de ambiente DATABASE_URL apontando para o mesmo
# banco usado pela aplicação (Supabase, Neon, Railway, RDS...).
#
# Uso:
#   DATABASE_URL=postgresql://... ./backup.sh
#
# Recomenda-se agendar via cron (ex.: diariamente) e manter uma política de
# retenção (ex.: apagar backups com mais de 30 dias) — ver exemplo ao final.
set -eu

: "${DATABASE_URL:?defina DATABASE_URL antes de rodar o backup}"

STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="backups/$STAMP"
mkdir -p "$DEST"

pg_dump "$DATABASE_URL" --format=custom --file="$DEST/database.dump"

if [ -f "app/data/.gestao-fiscal.key" ]; then
  cp "app/data/.gestao-fiscal.key" "$DEST/.gestao-fiscal.key"
fi

echo "Backup concluído em $DEST"
echo "Para restaurar: pg_restore --clean --if-exists -d \"\$DATABASE_URL\" $DEST/database.dump"

# Exemplo de retenção (mantém os últimos 30 backups):
# ls -1dt backups/*/ | tail -n +31 | xargs -r rm -rf
