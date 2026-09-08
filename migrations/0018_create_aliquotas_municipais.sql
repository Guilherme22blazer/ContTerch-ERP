-- Base de alíquotas de ISS por município, código de tributação e período de
-- vigência. Dados de origem: arquivos oficiais fornecidos pelo cliente, um
-- por UF (ver migrations 0019-0023 para a carga inicial). Histórico
-- completo é preservado (dt_ini/dt_fim); a alíquota "vigente hoje" é
-- resolvida em tempo de consulta (maior dt_ini <= data atual cujo período
-- ainda não encerrou), nunca hardcoded.

CREATE TABLE IF NOT EXISTS aliquotas_municipais_iss (
  codigo_ibge TEXT NOT NULL,
  uf TEXT NOT NULL,
  nome_municipio TEXT NOT NULL,
  codigo_servico TEXT NOT NULL,
  aliquota DOUBLE PRECISION,
  dt_ini DATE NOT NULL,
  dt_fim DATE,
  PRIMARY KEY (codigo_ibge, codigo_servico, dt_ini)
);

CREATE INDEX IF NOT EXISTS idx_aliq_mun_uf ON aliquotas_municipais_iss(uf);
CREATE INDEX IF NOT EXISTS idx_aliq_mun_municipio ON aliquotas_municipais_iss(nome_municipio);
CREATE INDEX IF NOT EXISTS idx_aliq_mun_servico ON aliquotas_municipais_iss(codigo_servico);
CREATE INDEX IF NOT EXISTS idx_aliq_mun_aliquota ON aliquotas_municipais_iss(aliquota);
CREATE INDEX IF NOT EXISTS idx_aliq_mun_vigencia ON aliquotas_municipais_iss(codigo_ibge, codigo_servico, dt_ini DESC);
