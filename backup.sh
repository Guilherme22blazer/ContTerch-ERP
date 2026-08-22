#!/bin/sh
set -eu

STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="backups/$STAMP"
TEMP_DB="/app/data/.backup-$STAMP.db"

mkdir -p "$DEST"

docker compose exec -T app python - "$TEMP_DB" <<'PY'
import sqlite3
import sys

source = sqlite3.connect("/app/data/simplescalc.db")
target = sqlite3.connect(sys.argv[1])
source.backup(target)
target.close()
source.close()
PY

cp "app/data/.backup-$STAMP.db" "$DEST/simplescalc.db"
rm -f "app/data/.backup-$STAMP.db"
cp "app/data/.gestao-fiscal.key" "$DEST/.gestao-fiscal.key"

echo "Backup concluído em $DEST"
