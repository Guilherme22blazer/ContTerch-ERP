"""Migra os dados do antigo banco SQLite (simplescalc.db) para o PostgreSQL
em nuvem configurado em DATABASE_URL.

Uso:
    DATABASE_URL=postgresql://... python3 migrate_sqlite_to_postgres.py [caminho/para/simplescalc.db]

O script:
  1. Aplica as migrations do PostgreSQL (idempotente).
  2. Garante a empresa padrão e o catálogo RBAC (roles/módulos/permissões).
  3. Copia os dados do SQLite preservando ids, senhas (hash) e blobs
     cifrados exatamente como estão — nenhuma senha ou certificado é
     decifrado ou recriado, então a chave Fernet (.gestao-fiscal.key)
     continua sendo necessária junto com o banco migrado.
  4. Ao final, compara a quantidade de registros de cada tabela entre a
     origem (SQLite) e o destino (PostgreSQL) e avisa sobre qualquer
     divergência, sem apagar o arquivo .db original.

Este script é seguro para reexecução: tabelas identificadas por id usam
ON CONFLICT DO NOTHING; tabelas de log sem chave natural (auditoria) são
puladas se o destino já tiver linhas, evitando duplicação.
"""

from __future__ import annotations

import sys
import sqlite3
from pathlib import Path

import db
import server


def source_connection(path: Path) -> sqlite3.Connection:
    if not path.exists():
        raise SystemExit(f"Arquivo SQLite não encontrado: {path}")
    connection = sqlite3.connect(str(path))
    connection.row_factory = sqlite3.Row
    return connection


def migrate_users(sqlite_db, pg, default_company_id: str, role_ids: dict[str, str]) -> int:
    rows = sqlite_db.execute("SELECT * FROM users").fetchall()
    for row in rows:
        perfil_id = role_ids["SUPER_ADMIN"] if row["role"] == "Administrador" else role_ids["USER"]
        pg.execute(
            """
            INSERT INTO users(
              email, name, role, salt, password_hash, password_algo, active, billing_cycle,
              subscription_value, monitoring_start, monitoring_end, last_login_at, previous_login_at,
              profile_photo_encrypted, profile_photo_mime, profile_photo_updated_at, id, document,
              phone, company, company_document, job_title, department, login, status, plan_id, notes,
              created_at, updated_at, created_by, updated_by, last_login_ip, login_attempts, blocked_at,
              company_id, perfil_id, primeiro_acesso
            ) VALUES (?, ?, ?, ?, ?, 'pbkdf2', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, FALSE)
            ON CONFLICT (email) DO NOTHING
            """,
            (
                row["email"], row["name"], row["role"], row["salt"], row["password_hash"], row["active"],
                row["billing_cycle"], row["subscription_value"], row["monitoring_start"], row["monitoring_end"],
                row["last_login_at"], row["previous_login_at"], row["profile_photo_encrypted"],
                row["profile_photo_mime"], row["profile_photo_updated_at"], row["id"], row["document"],
                row["phone"], row["company"], row["company_document"], row["job_title"], row["department"],
                row["login"], row["status"], row["plan_id"], row["notes"], row["created_at"], row["updated_at"],
                row["created_by"], row["updated_by"], row["last_login_ip"], row["login_attempts"], row["blocked_at"],
                default_company_id, perfil_id,
            ),
        )
    return len(rows)


def migrate_simple(sqlite_db, pg, table: str, columns: list[str], conflict_cols: str | None) -> int:
    rows = sqlite_db.execute(f"SELECT {', '.join(columns)} FROM {table}").fetchall()
    placeholders = ", ".join("?" for _ in columns)
    conflict_clause = f"ON CONFLICT ({conflict_cols}) DO NOTHING" if conflict_cols else ""
    for row in rows:
        pg.execute(
            f"INSERT INTO {table}({', '.join(columns)}) VALUES ({placeholders}) {conflict_clause}",
            tuple(row[c] for c in columns),
        )
    return len(rows)


def migrate_log_table(sqlite_db, pg, table: str, columns: list[str], id_column: str | None) -> int:
    """Para tabelas de log com id autoincremento (server_audit, access_audit,
    password_reset_attempts): pula a migração se o destino já tiver linhas
    (evita duplicar histórico em reexecuções), já que não há chave natural."""
    existing = pg.execute(f"SELECT COUNT(*) AS total FROM {table}").fetchone()["total"]
    if existing:
        print(f"  {table}: já possui {existing} linha(s) no destino, pulando.")
        return 0
    select_columns = [c for c in columns if c != id_column]
    rows = sqlite_db.execute(f"SELECT {', '.join(select_columns)} FROM {table}").fetchall()
    placeholders = ", ".join("?" for _ in select_columns)
    for row in rows:
        pg.execute(
            f"INSERT INTO {table}({', '.join(select_columns)}) VALUES ({placeholders})",
            tuple(row[c] for c in select_columns),
        )
    return len(rows)


def rename_user_permissions(sqlite_db, pg) -> int:
    rows = sqlite_db.execute("SELECT email, permission, allowed FROM user_permissions").fetchall()
    for row in rows:
        pg.execute(
            "INSERT INTO user_sefaz_permissions(email, permission, allowed) VALUES (?, ?, ?) ON CONFLICT DO NOTHING",
            (row["email"], row["permission"], row["allowed"]),
        )
    return len(rows)


def migrate_app_state(sqlite_db, pg, default_company_id: str) -> int:
    row = sqlite_db.execute("SELECT payload, updated_at, updated_by FROM app_state WHERE id = 1").fetchone()
    if row is None:
        return 0
    pg.execute(
        """
        INSERT INTO app_state(company_id, payload, updated_at, updated_by)
        VALUES (?, ?, ?, ?)
        ON CONFLICT (company_id) DO UPDATE SET
          payload = excluded.payload, updated_at = excluded.updated_at, updated_by = excluded.updated_by
        """,
        (default_company_id, row["payload"], row["updated_at"], row["updated_by"]),
    )
    return 1


def validate_counts(sqlite_db, pg, table_pairs: list[tuple[str, str]]) -> None:
    print("\n=== Validação de quantidade de registros ===")
    all_ok = True
    for source_table, dest_table in table_pairs:
        source_count = sqlite_db.execute(f"SELECT COUNT(*) FROM {source_table}").fetchone()[0]
        dest_count = pg.execute(f"SELECT COUNT(*) AS total FROM {dest_table}").fetchone()["total"]
        status = "OK" if dest_count >= source_count else "DIVERGENTE"
        if dest_count < source_count:
            all_ok = False
        print(f"  {source_table:28s} -> {dest_table:28s}  origem={source_count:5d}  destino={dest_count:5d}  [{status}]")
    print("=== Todas as tabelas conferidas ===" if all_ok else "!!! ALGUMA TABELA FICOU COM MENOS REGISTROS QUE A ORIGEM !!!")


def main() -> None:
    sqlite_path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent / "simplescalc.db"
    print(f"Origem (SQLite): {sqlite_path}")
    print(f"Destino (PostgreSQL): {server.masked_database_url()}")

    applied = db.run_migrations()
    if applied:
        print(f"Migrations aplicadas: {', '.join(applied)}")

    sqlite_db = source_connection(sqlite_path)

    with db.connect() as pg:
        default_company_id = server.ensure_default_company(pg)
        role_ids = server.ensure_rbac_seed(pg)
        print(f"Empresa padrão: {default_company_id}")

        migrated_users = migrate_users(sqlite_db, pg, default_company_id, role_ids)
        print(f"users: {migrated_users} migrado(s)")

        migrated_plans = migrate_simple(
            sqlite_db, pg, "access_plans",
            ["id", "name", "description", "monthly_value", "annual_value", "max_users", "trial_days", "status", "created_at", "updated_at"],
            "id",
        )
        print(f"access_plans: {migrated_plans} migrado(s)")

        migrated_plan_modules = migrate_simple(sqlite_db, pg, "plan_modules", ["plan_id", "module_key"], "plan_id, module_key")
        print(f"plan_modules: {migrated_plan_modules} migrado(s)")

        migrated_user_modules = migrate_simple(sqlite_db, pg, "user_modules", ["email", "module_key", "allowed"], "email, module_key")
        print(f"user_modules: {migrated_user_modules} migrado(s)")

        migrated_sefaz_permissions = rename_user_permissions(sqlite_db, pg)
        print(f"user_permissions -> user_sefaz_permissions: {migrated_sefaz_permissions} migrado(s)")

        migrated_certificates = migrate_simple(
            sqlite_db, pg, "fiscal_certificates",
            ["id", "company", "branch", "document", "holder", "issuer", "serial", "valid_from", "valid_until",
             "environment", "state_code", "pfx_encrypted", "password_encrypted", "save_password", "created_by",
             "created_at", "updated_at", "active"],
            "id",
        )
        print(f"fiscal_certificates: {migrated_certificates} migrado(s)")

        migrated_queries = migrate_simple(
            sqlite_db, pg, "fiscal_queries",
            ["id", "access_key", "model", "company", "certificate_id", "environment", "status", "risk_level",
             "official_code", "source_name", "source_url", "result_encrypted", "xml_encrypted", "xml_filename",
             "consulted_by", "consulted_at", "xml_sha256", "record_origin", "import_batch_id"],
            "id",
        )
        print(f"fiscal_queries: {migrated_queries} migrado(s)")

        migrated_documents = migrate_simple(
            sqlite_db, pg, "distributed_documents",
            ["id", "certificate_id", "environment", "state_code", "nsu", "schema_name", "document_type",
             "access_key", "direction", "status", "result_encrypted", "xml_encrypted", "synced_by", "received_at"],
            "id",
        )
        print(f"distributed_documents: {migrated_documents} migrado(s)")

        migrated_distribution_state = migrate_simple(
            sqlite_db, pg, "distribution_state",
            ["certificate_id", "environment", "state_code", "last_nsu", "max_nsu", "official_code", "motive", "updated_at"],
            "certificate_id, environment, state_code",
        )
        print(f"distribution_state: {migrated_distribution_state} migrado(s)")

        migrated_nfse_imports = migrate_simple(
            sqlite_db, pg, "nfse_monthly_imports",
            ["id", "certificate_id", "environment", "month", "source_filename", "source_sha256", "source_documents",
             "imported_documents", "duplicate_documents", "cancellation_events", "ignored_documents", "error_count",
             "is_complete", "imported_by", "imported_at"],
            "id",
        )
        print(f"nfse_monthly_imports: {migrated_nfse_imports} migrado(s)")

        migrated_reset_tokens = migrate_simple(
            sqlite_db, pg, "password_reset_tokens",
            ["id", "email", "token_hash", "created_at", "expires_at", "used_at", "ip_address"],
            "id",
        )
        print(f"password_reset_tokens: {migrated_reset_tokens} migrado(s)")

        migrated_reset_attempts = migrate_log_table(
            sqlite_db, pg, "password_reset_attempts",
            ["id", "email", "ip_address", "attempted_at", "successful"], "id",
        )
        print(f"password_reset_attempts: {migrated_reset_attempts} migrado(s)")

        migrated_server_audit = migrate_log_table(
            sqlite_db, pg, "server_audit", ["id", "created_at", "email", "action", "detail"], "id",
        )
        print(f"server_audit: {migrated_server_audit} migrado(s)")

        migrated_access_audit = migrate_log_table(
            sqlite_db, pg, "access_audit",
            ["id", "created_at", "administrator_email", "affected_email", "action", "previous_value", "new_value", "ip_address"],
            "id",
        )
        print(f"access_audit: {migrated_access_audit} migrado(s)")

        migrated_state = migrate_app_state(sqlite_db, pg, default_company_id)
        print(f"app_state: {migrated_state} migrado(s)")

        validate_counts(sqlite_db, pg, [
            ("users", "users"),
            ("access_plans", "access_plans"),
            ("plan_modules", "plan_modules"),
            ("user_modules", "user_modules"),
            ("user_permissions", "user_sefaz_permissions"),
            ("fiscal_certificates", "fiscal_certificates"),
            ("fiscal_queries", "fiscal_queries"),
            ("distributed_documents", "distributed_documents"),
            ("distribution_state", "distribution_state"),
            ("nfse_monthly_imports", "nfse_monthly_imports"),
            ("password_reset_tokens", "password_reset_tokens"),
            ("app_state", "app_state"),
        ])
    sqlite_db.close()
    print("\nMigração concluída. O arquivo SQLite original NÃO foi apagado — "
          "remova-o manualmente somente depois de validar o sistema em produção com o PostgreSQL.")


if __name__ == "__main__":
    main()
