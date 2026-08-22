ALTER TABLE fiscal_certificates ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);
ALTER TABLE fiscal_queries ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);
ALTER TABLE distributed_documents ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);
ALTER TABLE distribution_state ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);
ALTER TABLE nfse_monthly_imports ADD COLUMN IF NOT EXISTS company_id TEXT REFERENCES companies(id);

CREATE INDEX IF NOT EXISTS idx_fiscal_certificates_company ON fiscal_certificates(company_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_queries_company ON fiscal_queries(company_id);
CREATE INDEX IF NOT EXISTS idx_distributed_documents_company ON distributed_documents(company_id);
CREATE INDEX IF NOT EXISTS idx_nfse_monthly_imports_company ON nfse_monthly_imports(company_id);
