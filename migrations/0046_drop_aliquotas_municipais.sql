-- Remove a funcionalidade de Alíquotas Municipais e libera o espaço em disco
-- ocupado pela tabela (base de ISS por município cresceu para mais de 500MB
-- e esgotou o volume do banco de produção).
DROP TABLE IF EXISTS aliquotas_municipais_iss CASCADE;
