-- migrations/0013 adicionou company_id em fiscal_certificates/fiscal_queries/
-- distributed_documents/distribution_state/nfse_monthly_imports, mas nenhum
-- INSERT do servidor preenchia essa coluna — todas as linhas continuavam com
-- company_id NULL, o que tornava inofensivo qualquer filtro "WHERE company_id
-- = ?" adicionado depois (nunca bateria com nada). Este backfill único
-- popula o histórico existente antes do código passar a exigir o filtro em
-- toda leitura sensível (ver server.py: certificate_row, build_documents_explorer,
-- /api/sefaz/bootstrap, etc.).

-- 1) Certificados: deriva a empresa a partir de quem cadastrou (created_by).
UPDATE fiscal_certificates fc
SET company_id = u.company_id
FROM users u
WHERE fc.company_id IS NULL AND fc.created_by = u.email AND u.company_id IS NOT NULL;

-- 2) Demais tabelas: derivam a empresa a partir do certificado usado na
-- consulta/sincronização (já teria sido corrigido no passo 1 acima).
UPDATE fiscal_queries fq
SET company_id = fc.company_id
FROM fiscal_certificates fc
WHERE fq.company_id IS NULL AND fq.certificate_id = fc.id AND fc.company_id IS NOT NULL;

UPDATE distributed_documents dd
SET company_id = fc.company_id
FROM fiscal_certificates fc
WHERE dd.company_id IS NULL AND dd.certificate_id = fc.id AND fc.company_id IS NOT NULL;

UPDATE distribution_state ds
SET company_id = fc.company_id
FROM fiscal_certificates fc
WHERE ds.company_id IS NULL AND ds.certificate_id = fc.id AND fc.company_id IS NOT NULL;

UPDATE nfse_monthly_imports ni
SET company_id = fc.company_id
FROM fiscal_certificates fc
WHERE ni.company_id IS NULL AND ni.certificate_id = fc.id AND fc.company_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_distribution_state_company ON distribution_state(company_id);
