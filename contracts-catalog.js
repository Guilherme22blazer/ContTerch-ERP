(function () {
  'use strict';

  var SOURCES = {
    CLT: { label: 'CLT — Decreto-Lei nº 5.452/1943', url: 'https://www.planalto.gov.br/ccivil_03/decreto-lei/del5452compilado.htm' },
    CIVIL: { label: 'Código Civil — Lei nº 10.406/2002', url: 'https://www.planalto.gov.br/ccivil_03/leis/2002/l10406compilada.htm' },
    ESTAGIO: { label: 'Lei do Estágio — Lei nº 11.788/2008', url: 'https://www.planalto.gov.br/ccivil_03/_ato2007-2010/2008/lei/l11788.htm' },
    TEMP: { label: 'Trabalho Temporário — Lei nº 6.019/1974', url: 'https://www.planalto.gov.br/ccivil_03/leis/l6019compilado.htm' },
    DOMESTICO: { label: 'Empregado Doméstico — LC nº 150/2015', url: 'https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp150.htm' },
    LGPD: { label: 'LGPD — Lei nº 13.709/2018', url: 'https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709compilado.htm' },
    APRENDIZ: { label: 'Aprendizagem — CLT, arts. 428 a 433', url: 'https://www.planalto.gov.br/ccivil_03/decreto-lei/del5452compilado.htm' },
    RURAL: { label: 'Trabalho Rural — Lei nº 5.889/1973', url: 'https://www.planalto.gov.br/ccivil_03/leis/l5889.htm' },
    REPRESENTACAO: { label: 'Representação Comercial — Lei nº 4.886/1965', url: 'https://www.planalto.gov.br/ccivil_03/leis/l4886.htm' },
    FRANQUIA: { label: 'Lei de Franquia — Lei nº 13.966/2019', url: 'https://www.planalto.gov.br/ccivil_03/_ato2019-2022/2019/lei/l13966.htm' },
    LOCACAO: { label: 'Lei de Locações — Lei nº 8.245/1991', url: 'https://www.planalto.gov.br/ccivil_03/leis/l8245.htm' },
    SALAO: { label: 'Salão Parceiro — Lei nº 13.352/2016', url: 'https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2016/lei/l13352.htm' },
    STARTUP: { label: 'Marco Legal das Startups — LC nº 182/2021', url: 'https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp182.htm' },
    LIMITADA: { label: 'Manual de Registro de Sociedade Limitada — DREI', url: 'https://www.gov.br/empresas-e-negocios/pt-br/drei/legislacao/instrucoes-normativas/arquivos-instrucoes-normativas-em-vigor/anexo-iv-limitada_compilada.pdf/@@download/file' },
    DREI: { label: 'IN DREI nº 81/2020 e manuais de registro', url: 'https://www.gov.br/empresas-e-negocios/pt-br/drei/legislacao/instrucoes-normativas' },
    SA: { label: 'Lei das Sociedades por Ações — Lei nº 6.404/1976', url: 'https://www.planalto.gov.br/ccivil_03/leis/l6404consol.htm' },
    COOP: { label: 'Sociedades Cooperativas — Lei nº 5.764/1971', url: 'https://www.planalto.gov.br/ccivil_03/leis/l5764.htm' },
    OSC: { label: 'Marco Regulatório das OSC — Lei nº 13.019/2014', url: 'https://www.planalto.gov.br/ccivil_03/_ato2011-2014/2014/lei/l13019.htm' }
  };

  var definitions = [];
  function add(category, group, template, sourceCode, titles) {
    titles.forEach(function (title) { definitions.push([category, group, template, sourceCode, title]); });
  }

  add('Contratos Trabalhistas', 'Admissão e modalidades', 'employment', 'CLT', [
    'Contrato de trabalho por prazo indeterminado',
    'Contrato de trabalho por prazo determinado — art. 443 da CLT',
    'Contrato de experiência',
    'Contrato de trabalho intermitente',
    'Contrato de teletrabalho ou trabalho remoto',
    'Contrato por obra certa',
    'Contrato de trabalho por safra',
    'Contrato de trabalho rural',
    'Contrato de atleta profissional',
    'Contrato de músicos, artistas e técnicos de espetáculos',
    'Contrato misto de empregado meeiro'
  ]);
  add('Contratos Trabalhistas', 'Admissão e modalidades', 'apprenticeship', 'APRENDIZ', ['Contrato de aprendizagem profissional']);
  add('Contratos Trabalhistas', 'Admissão e modalidades', 'internship', 'ESTAGIO', ['Termo de compromisso de estágio','Convênio para concessão de estágio']);
  add('Contratos Trabalhistas', 'Admissão e modalidades', 'temporary', 'TEMP', ['Contrato de trabalho temporário','Contrato de prestação de serviços de terceirização']);
  add('Contratos Trabalhistas', 'Empregado doméstico', 'domestic', 'DOMESTICO', ['Contrato de trabalho doméstico','Acordo de prorrogação de jornada do empregado doméstico','Acordo de banco de horas do empregado doméstico','Termo aditivo do contrato doméstico']);
  add('Contratos Trabalhistas', 'Jornada e compensação', 'hours', 'CLT', [
    'Acordo individual de banco de horas',
    'Acordo coletivo de banco de horas',
    'Acordo de compensação semanal — semana inglesa',
    'Acordo de compensação de horas dentro do mês',
    'Acordo de prorrogação do horário de trabalho',
    'Acordo de prorrogação e compensação de jornada',
    'Termo de controle de trabalho externo'
  ]);
  add('Contratos Trabalhistas', 'Alterações contratuais', 'employment-addendum', 'CLT', [
    'Termo aditivo ao contrato de trabalho',
    'Aditivo de alteração de função',
    'Aditivo de alteração salarial',
    'Aditivo de alteração de jornada',
    'Aditivo para mudança ao regime de teletrabalho',
    'Aditivo para retorno ao trabalho presencial',
    'Aditivo de transferência de local de trabalho'
  ]);
  add('Contratos Trabalhistas', 'Proteção de dados e sigilo', 'privacy-employment', 'LGPD', [
    'Termo de confidencialidade e sigilo do empregado',
    'Termo de ciência para tratamento de dados pessoais do empregado',
    'Termo de consentimento para processo seletivo',
    'Termo de consentimento para empregado menor de 18 anos',
    'Termo de consentimento de dependente maior de 18 anos',
    'Termo de consentimento para dados de dependente menor',
    'Termo de ciência após a rescisão do contrato',
    'Termo para compartilhamento de dados de empregado terceirizado',
    'Aditivo de proteção de dados para prestador autônomo',
    'Termo de autorização de uso de imagem e voz'
  ]);
  add('Contratos Trabalhistas', 'Responsabilidade e SST', 'responsibility-employment', 'CLT', [
    'Termo de responsabilidade por uniforme',
    'Termo de responsabilidade por equipamentos e ferramentas',
    'Termo de responsabilidade por utilização de veículo da empresa',
    'Termo de entrega e responsabilidade por EPI',
    'Ordem de serviço de segurança e saúde no trabalho',
    'Termo de uso aceitável de equipamentos e sistemas'
  ]);
  add('Contratos Trabalhistas', 'Disciplina e desligamento', 'employment-notice', 'CLT', [
    'Advertência disciplinar',
    'Suspensão disciplinar',
    'Comunicado de dispensa por justa causa',
    'Aviso-prévio trabalhado para dispensa',
    'Aviso-prévio indenizado para dispensa',
    'Pedido de demissão com aviso-prévio trabalhado',
    'Pedido de demissão com dispensa do aviso-prévio',
    'Acordo de extinção do contrato de trabalho',
    'Carta de recomendação profissional'
  ]);
  add('Contratos Trabalhistas', 'Prestadores e parceiros', 'services', 'CIVIL', ['Contrato de prestação de serviços por trabalhador autônomo','Recibo de pagamento a autônomo — RPA','Recibo de pró-labore']);
  add('Contratos Trabalhistas', 'Prestadores e parceiros', 'representation', 'REPRESENTACAO', ['Contrato de representação comercial por prazo indeterminado','Contrato de representação comercial por prazo determinado','Contrato de sub-representação comercial']);
  add('Contratos Trabalhistas', 'Prestadores e parceiros', 'salon', 'SALAO', ['Contrato de parceria — salão parceiro e profissional parceiro']);

  add('Contratos Comerciais', 'Prestação de serviços', 'services', 'CIVIL', [
    'Contrato de prestação de serviços profissionais',
    'Contrato de consultoria empresarial',
    'Contrato de serviços contábeis',
    'Contrato de serviços jurídicos',
    'Contrato de serviços de marketing e publicidade',
    'Contrato de manutenção preventiva e corretiva',
    'Contrato de limpeza e conservação',
    'Contrato de vigilância e segurança privada',
    'Contrato de transporte de cargas',
    'Contrato de armazenagem e depósito',
    'Contrato de empreitada por preço global',
    'Contrato de empreitada por administração'
  ]);
  add('Contratos Comerciais', 'Tecnologia e dados', 'technology', 'CIVIL', [
    'Contrato de desenvolvimento de software',
    'Contrato de licenciamento de software',
    'Contrato de software como serviço — SaaS',
    'Contrato de hospedagem e suporte técnico',
    'Contrato de cessão de direitos patrimoniais de software',
    'Acordo de níveis de serviço — SLA'
  ]);
  add('Contratos Comerciais', 'Tecnologia e dados', 'data-processing', 'LGPD', ['Contrato de tratamento de dados pessoais entre controlador e operador','Acordo de compartilhamento de dados pessoais','Acordo de confidencialidade — NDA bilateral','Acordo de confidencialidade — NDA unilateral']);
  add('Contratos Comerciais', 'Compra, venda e fornecimento', 'sale', 'CIVIL', [
    'Contrato de compra e venda de mercadorias',
    'Contrato de compra e venda de bem móvel',
    'Contrato de compra e venda de veículo',
    'Contrato de compra e venda de imóvel',
    'Promessa de compra e venda de imóvel',
    'Contrato de fornecimento continuado',
    'Contrato de distribuição comercial',
    'Contrato estimatório — consignação mercantil'
  ]);
  add('Contratos Comerciais', 'Intermediação e expansão', 'representation', 'REPRESENTACAO', ['Contrato de representação comercial','Contrato de agência e distribuição','Contrato de comissão mercantil','Contrato de corretagem']);
  add('Contratos Comerciais', 'Intermediação e expansão', 'franchise', 'FRANQUIA', ['Contrato de franquia empresarial','Pré-contrato de franquia']);
  add('Contratos Comerciais', 'Investimentos e crédito', 'investment', 'STARTUP', ['Contrato de participação de investidor-anjo','Mútuo conversível em participação societária','Acordo de investimento em startup']);
  add('Contratos Comerciais', 'Investimentos e crédito', 'loan', 'CIVIL', ['Contrato de mútuo financeiro','Contrato de confissão e parcelamento de dívida','Instrumento de novação de dívida','Cessão de crédito','Contrato de factoring — fomento mercantil']);
  add('Contratos Comerciais', 'Uso e cessão de bens', 'lease', 'LOCACAO', ['Contrato de locação residencial','Contrato de locação comercial','Contrato de sublocação','Contrato de locação de bem móvel','Contrato de arrendamento de estabelecimento empresarial']);
  add('Contratos Comerciais', 'Uso e cessão de bens', 'commodatum', 'CIVIL', ['Contrato de comodato de bem móvel','Contrato de comodato de imóvel','Contrato de doação','Contrato de doação com reserva de usufruto','Instrumento de constituição de usufruto']);
  add('Contratos Comerciais', 'Parcerias e encerramento', 'partnership', 'CIVIL', ['Contrato de parceria empresarial','Contrato de cooperação comercial','Contrato de consórcio entre empresas','Distrato de prestação de serviços','Termo de quitação e encerramento contratual','Acordo extrajudicial']);
  add('Contratos Comerciais', 'Instrumentos auxiliares', 'auxiliary', 'CIVIL', ['Procuração particular para atos empresariais','Carta de cobrança','Carta de anuência','Recibo de pagamento','Termo de entrega e recebimento','Ata de reunião comercial']);

  add('Contratos Societários', 'Sociedade limitada', 'limited-company', 'LIMITADA', [
    'Contrato social de sociedade limitada',
    'Ato constitutivo de sociedade limitada unipessoal',
    'Contrato social de holding limitada',
    'Contrato social de sociedade de propósito específico — SPE Ltda.',
    'Contrato social de escritório contábil',
    'Contrato social de clínica médica',
    'Contrato social de engenharia',
    'Contrato social de transportes de cargas'
  ]);
  add('Contratos Societários', 'Alterações de limitada', 'company-amendment', 'LIMITADA', [
    'Alteração contratual — modelo básico',
    'Alteração contratual para admissão de novo sócio',
    'Alteração contratual para retirada de sócio',
    'Alteração contratual para cessão e transferência de quotas',
    'Alteração contratual para aumento de capital em dinheiro',
    'Alteração contratual para aumento de capital com bens',
    'Alteração contratual para redução de capital',
    'Alteração contratual para mudança de objeto social',
    'Alteração contratual para mudança de endereço',
    'Alteração contratual para mudança de nome empresarial',
    'Alteração contratual para designação de administrador',
    'Alteração contratual para abertura de filial',
    'Alteração contratual para fechamento de filial',
    'Alteração contratual por falecimento de sócio',
    'Instrumento de re-ratificação do contrato social'
  ]);
  add('Contratos Societários', 'Deliberações e encerramento', 'corporate-minutes', 'LIMITADA', [
    'Ata de reunião de sócios para aprovação de contas',
    'Ata de reunião de sócios para distribuição de lucros',
    'Ata de reunião de sócios para designação de administrador',
    'Edital de convocação de reunião ou assembleia de sócios',
    'Ata de dissolução da sociedade',
    'Ata de liquidação da sociedade',
    'Ata de extinção da sociedade',
    'Distrato social de sociedade limitada'
  ]);
  add('Contratos Societários', 'Sociedade simples e profissionais', 'simple-company', 'CIVIL', ['Contrato social de sociedade simples','Contrato social de sociedade simples limitada','Contrato social de sociedade de advogados','Ato constitutivo de sociedade individual de advocacia','Distrato de sociedade simples']);
  add('Contratos Societários', 'Sociedades por ações', 'corporation', 'SA', ['Ata de constituição de sociedade anônima','Estatuto social de sociedade anônima fechada','Estatuto social de holding S.A.','Ata de assembleia geral ordinária','Ata de assembleia geral extraordinária','Ata de reunião de diretoria','Acordo de acionistas','Distrato e encerramento de sociedade anônima']);
  add('Contratos Societários', 'Cooperativas e terceiro setor', 'cooperative', 'COOP', ['Ata de constituição de cooperativa','Estatuto social de cooperativa','Edital de convocação de assembleia de cooperativa','Ata de assembleia geral de cooperativa']);
  add('Contratos Societários', 'Cooperativas e terceiro setor', 'association', 'OSC', ['Ata de constituição de associação','Estatuto social de associação','Estatuto de organização não governamental — ONG','Estatuto de organização da sociedade civil — OSC','Ata de alteração de endereço de associação','Ata de prestação de contas da diretoria','Ata de dissolução de associação']);
  add('Contratos Societários', 'Empresário e reorganizações', 'reorganization', 'DREI', ['Instrumento de inscrição de empresário individual','Transformação de empresário individual em sociedade limitada','Transformação de sociedade simples em sociedade limitada','Transformação de sociedade limitada em sociedade simples','Protocolo de incorporação','Protocolo de fusão','Protocolo de cisão parcial','Contrato de constituição de sociedade em conta de participação','Contrato de sociedade em nome coletivo','Convenção de grupo de sociedades']);
  add('Contratos Societários', 'Acordos entre sócios', 'shareholders', 'CIVIL', ['Acordo de sócios de sociedade limitada','Acordo de quotistas com regras de saída','Acordo de vesting e opção de compra de quotas','Protocolo familiar e sucessório','Termo de doação de quotas com reserva de usufruto']);

  window.GESTAO_FISCAL_CONTRACT_SOURCES = SOURCES;
  window.GESTAO_FISCAL_CONTRACTS = definitions.map(function (row, index) {
    var source = SOURCES[row[3]] || SOURCES.CIVIL;
    return {
      id: 'contract-' + String(index + 1).padStart(3, '0'), category: row[0], group: row[1], template: row[2], sourceCode: row[3], title: row[4],
      description: 'Modelo orientativo e editável de ' + row[4].toLocaleLowerCase('pt-BR') + ', com cláusulas essenciais, qualificação das partes, prazos, valores, assinaturas e conferência jurídica.',
      source: source.label, sourceUrl: source.url, updated: '20/08/2026', keywords: [row[0], row[1], row[2], row[4], source.label].join(' '), custom: false
    };
  });
  window.GESTAO_FISCAL_CONTRACTS_META = {
    checkedAt: '20/08/2026', count: definitions.length,
    referenceUrl: 'https://www.econeteditora.com.br/links_pagina_inicial/contratos/contratos_inicial.asp',
    disclaimer: 'Biblioteca própria e orientativa. Os modelos não reproduzem conteúdo proprietário e devem ser revisados por profissional habilitado antes da assinatura ou do registro.'
  };
}());
