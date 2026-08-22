"""Camada de acesso ao PostgreSQL em nuvem.

Substitui o antigo backend SQLite local (`simplescalc.db`). A conexão é
sempre feita através da variável de ambiente `DATABASE_URL`, compatível com
qualquer provedor PostgreSQL (Supabase, Neon, Railway, AWS RDS, etc.).

Para minimizar o número de pontos de alteração no `server.py` (que já usava
`with connect() as database: database.execute("... WHERE x = ?", (...))`
no estilo do `sqlite3`), `connect()` aqui devolve uma conexão do pool cujo
`.execute()` aceita o mesmo placeholder posicional `?` do SQLite, traduzindo
automaticamente para o `%s` esperado pelo protocolo do PostgreSQL.
"""

from __future__ import annotations

import os
import threading
from pathlib import Path

import psycopg
import psycopg_pool
from psycopg import errors as pg_errors
from psycopg.rows import dict_row
from psycopg_pool import ConnectionPool

IntegrityError = pg_errors.IntegrityError
OperationalError = pg_errors.OperationalError
# Erros de conexão/indisponibilidade do banco (útil para uma mensagem amigável
# em vez de um traceback cru quando DATABASE_URL aponta para algo inacessível).
ConnectionIssue = (pg_errors.OperationalError, psycopg_pool.PoolTimeout)

MIGRATIONS_DIR = Path(__file__).resolve().parent / "migrations"


def _qmark_to_pyformat(sql: str) -> str:
    """Traduz '?' (estilo sqlite3) para '%s' (estilo psycopg).

    Nenhuma consulta deste projeto embute um '?' literal dentro de uma
    string SQL, então a substituição direta é segura.
    """
    return sql.replace("?", "%s")


class CompatConnection(psycopg.Connection):
    """Conexão psycopg com um `.execute()` compatível com sqlite3.Connection."""

    def execute(self, query, params=None, **kwargs):  # type: ignore[override]
        translated = _qmark_to_pyformat(query) if isinstance(query, str) else query
        return super().execute(translated, params, **kwargs)


_pool: ConnectionPool | None = None
_pool_lock = threading.Lock()


def _database_url() -> str:
    url = os.environ.get("DATABASE_URL", "").strip()
    if not url:
        raise RuntimeError(
            "DATABASE_URL não configurada. Defina a connection string do "
            "PostgreSQL (Supabase, Neon, Railway, RDS ou outro serviço "
            "compatível) na variável de ambiente DATABASE_URL."
        )
    return url


def get_pool() -> ConnectionPool:
    global _pool
    if _pool is None:
        with _pool_lock:
            if _pool is None:
                _pool = ConnectionPool(
                    conninfo=_database_url(),
                    connection_class=CompatConnection,
                    kwargs={"row_factory": dict_row, "autocommit": False},
                    min_size=1,
                    max_size=int(os.environ.get("DATABASE_POOL_MAX", "10")),
                    open=True,
                )
    return _pool


def connect():
    """Equivalente ao antigo `sqlite3.connect(DB_PATH)`.

    Uso idêntico ao anterior:

        with connect() as database:
            database.execute("SELECT 1 FROM users WHERE email = ?", (email,))

    Ao sair do bloco sem exceção a transação é confirmada (commit) e a
    conexão devolvida ao pool; em caso de exceção, é revertida (rollback).
    """
    return get_pool().connection()


def close_pool() -> None:
    global _pool
    if _pool is not None:
        _pool.close()
        _pool = None


def run_migrations() -> list[str]:
    """Aplica, em ordem alfabética, as migrations *.sql ainda não registradas."""
    applied: list[str] = []
    with get_pool().connection() as database:
        database.execute(
            """
            CREATE TABLE IF NOT EXISTS schema_migrations (
              version TEXT PRIMARY KEY,
              applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
            )
            """
        )
        already = {
            row["version"]
            for row in database.execute("SELECT version FROM schema_migrations").fetchall()
        }
        for path in sorted(MIGRATIONS_DIR.glob("*.sql")):
            version = path.stem
            if version in already:
                continue
            sql = path.read_text(encoding="utf-8")
            database.execute(sql)
            database.execute("INSERT INTO schema_migrations(version) VALUES (%s)", (version,))
            applied.append(version)
    return applied
