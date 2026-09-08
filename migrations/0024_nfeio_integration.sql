-- Integração com a API oficial da NFE.io (https://nfe.io) para emissão de
-- NFe/NFCe (nota fiscal de produto), consulta e cancelamento, reaproveitando
-- o certificado digital A1 já cadastrado em fiscal_certificates.
--
-- A API Key é uma credencial da conta NFE.io de cada empresa cliente do ERP
-- (não é gerada por este sistema) e fica cifrada em repouso, no mesmo padrão
-- já usado para o Stripe (platform_settings) e para a senha do certificado
-- (fiscal_certificates.password_encrypted).

CREATE TABLE IF NOT EXISTS nfeio_settings (
  company_id TEXT PRIMARY KEY REFERENCES companies(id),
  api_key_encrypted BYTEA,
  nfeio_company_id TEXT,
  certificate_id TEXT REFERENCES fiscal_certificates(id),
  certificate_synced_at TEXT,
  certificate_valid_until TEXT,
  environment TEXT NOT NULL DEFAULT 'production',
  updated_by TEXT,
  updated_at TEXT
);

CREATE TABLE IF NOT EXISTS nfeio_invoices (
  id TEXT PRIMARY KEY,
  company_id TEXT NOT NULL REFERENCES companies(id),
  kind TEXT NOT NULL,
  nfeio_id TEXT,
  status TEXT NOT NULL DEFAULT 'Pending',
  status_reason TEXT,
  buyer_name TEXT,
  buyer_document TEXT,
  total_value DOUBLE PRECISION,
  pdf_url TEXT,
  xml_url TEXT,
  request_encrypted BYTEA,
  response_encrypted BYTEA,
  created_by TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  CONSTRAINT nfeio_invoices_kind_check CHECK (kind IN ('nfe', 'nfce', 'cfe'))
);

CREATE INDEX IF NOT EXISTS idx_nfeio_invoices_company ON nfeio_invoices(company_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_nfeio_invoices_nfeio_id ON nfeio_invoices(nfeio_id);
CREATE INDEX IF NOT EXISTS idx_nfeio_invoices_status ON nfeio_invoices(status);
