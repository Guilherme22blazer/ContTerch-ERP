(function () {
  'use strict';

  var INSS_FORMS = 'https://www.gov.br/inss/pt-br/centrais-de-conteudo/formularios/formularios';
  var MEU_INSS = 'https://meu.inss.gov.br/';
  var RFB = 'https://www.gov.br/receitafederal/pt-br';
  var forms = [
    {
      id: 'cat', category: 'Trabalhista / Previdenciário', title: 'CAT — Comunicação de Acidente do Trabalho',
      description: 'Registra acidente de trabalho, acidente de trajeto, doença ocupacional, reabertura ou óbito.', template: 'cat', type: 'PDF oficial e preenchimento', issuer: 'INSS', updated: '06/11/2025',
      officialUrl: 'https://www.gov.br/inss/pt-br/centrais-de-conteudo/formularios/copy_of_CAT.pdf', downloadUrl: 'https://www.gov.br/inss/pt-br/centrais-de-conteudo/formularios/copy_of_CAT.pdf', tags: 'acidente trabalho empregado atestado médico CAT'
    },
    {
      id: 'declaracao-tempo-contribuicao', category: 'Trabalhista / Previdenciário', title: 'Declaração de Tempo de Contribuição',
      description: 'Modelo de apoio para declarar vínculos e períodos de contribuição previdenciária.', template: 'periods', type: 'Modelo preenchível', issuer: 'INSS / órgão previdenciário', updated: '20/08/2026', officialUrl: INSS_FORMS, tags: 'tempo contribuição período vínculo CTC'
    },
    {
      id: 'declaracao-tempo-auxiliar-local', category: 'Trabalhista / Previdenciário', title: 'Declaração de Tempo de Contribuição referente ao Auxiliar Local',
      description: 'Declara períodos e remunerações de auxiliar local vinculado a missão ou repartição brasileira no exterior.', template: 'periods', type: 'Modelo preenchível', issuer: 'Órgão empregador / INSS', updated: '20/08/2026', officialUrl: INSS_FORMS, tags: 'auxiliar local exterior contribuição declaração'
    },
    {
      id: 'declaracao-empregador-domestico', category: 'Trabalhista / Previdenciário', title: 'Declaração do Empregador Doméstico para o Empregado',
      description: 'Declara vínculo, função, remuneração e período do empregado doméstico.', template: 'employment', type: 'Modelo preenchível', issuer: 'Empregador doméstico', updated: '20/08/2026', officialUrl: 'https://www.gov.br/esocial/pt-br/empregador-domestico', tags: 'doméstico empregador empregado vínculo salário'
    },
    {
      id: 'gps', category: 'Trabalhista / Previdenciário', title: 'GPS — Guia da Previdência Social',
      description: 'Ficha de apoio para conferência de identificação, competência, código de pagamento e valores da GPS.', template: 'gps', type: 'Conferência preenchível', issuer: 'Receita Federal / INSS', updated: '20/08/2026', officialUrl: 'https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/calculo-da-guia-da-previdencia-social-gps', tags: 'GPS guia previdência INSS contribuição competência'
    },
    {
      id: 'lgpd-incidente', category: 'Trabalhista / Previdenciário', title: 'LGPD — Comunicação de Incidente de Segurança com Dados Pessoais à ANPD',
      description: 'Organiza as informações exigidas para avaliação e comunicação de incidente com dados pessoais.', template: 'incident', type: 'Formulário de apoio + serviço oficial', issuer: 'ANPD', updated: '04/08/2026', officialUrl: 'https://www.gov.br/anpd/pt-br/canais_atendimento/agente-de-tratamento/comunicado-de-incidente-de-seguranca-cis', tags: 'LGPD incidente segurança ANPD dados pessoais controlador'
    },
    {
      id: 'pedido-prorrogacao', category: 'Trabalhista / Previdenciário', title: 'Pedido de Prorrogação — PP',
      description: 'Dados de apoio para solicitar prorrogação de benefício por incapacidade temporária.', template: 'benefit', type: 'Serviço on-line', issuer: 'INSS', updated: '20/08/2026', officialUrl: MEU_INSS, tags: 'prorrogação benefício incapacidade DCB perícia'
    },
    {
      id: 'restituicao-contribuicao-previdenciaria', category: 'Trabalhista / Previdenciário', title: 'Pedido de Restituição de Valores Indevidos relativos à Contribuição Previdenciária',
      description: 'Organiza pagamentos, competências e justificativa para restituição ou compensação.', template: 'refund', type: 'Formulário de apoio', issuer: 'Receita Federal', updated: '20/08/2026', officialUrl: 'https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/restituicao-ressarcimento-reembolso-e-compensacao', tags: 'restituição contribuição previdenciária pagamento indevido PERDCOMP'
    },
    {
      id: 'ppp', category: 'Trabalhista / Previdenciário', title: 'Perfil Profissiográfico Previdenciário — PPP',
      description: 'Dados administrativos, registros ambientais, agentes de risco e responsáveis técnicos do histórico laboral.', template: 'ppp', type: 'PDF oficial e serviço eletrônico', issuer: 'INSS / eSocial', updated: '15/12/2025',
      officialUrl: 'https://www.gov.br/pt-br/servicos/emitir-ppp-eletronico-perfil-profissiografico-previdenciario', downloadUrl: 'https://www.gov.br/inss_/pt-br/centrais-de-conteudo/publicacoes/outras/ppp.pdf', tags: 'PPP perfil profissiográfico risco ambiente eSocial'
    },
    {
      id: 'convenio-salario-familia', category: 'Trabalhista / Previdenciário', title: 'Proposta de Convênio para Pagamento de Salário-Família',
      description: 'Proposta com identificação do convenente, empregados abrangidos e responsabilidades.', template: 'agreement', type: 'Modelo preenchível', issuer: 'INSS', updated: '06/11/2025', officialUrl: INSS_FORMS, tags: 'convênio salário família empregador'
    },
    {
      id: 'beneficio-assistencial', category: 'Trabalhista / Previdenciário', title: 'Requerimento de Benefício Assistencial — Lei nº 8.742/1993',
      description: 'Acesso ao requerimento do Benefício de Prestação Continuada e ficha de organização dos dados.', template: 'benefit', type: 'Serviço on-line', issuer: 'INSS', updated: '20/08/2026', officialUrl: 'https://www.gov.br/pt-br/servicos/solicitar-beneficio-assistencial-a-pessoa-com-deficiencia', tags: 'BPC LOAS benefício assistencial deficiência idoso'
    },
    {
      id: 'beneficio-incapacidade-online', category: 'Trabalhista / Previdenciário', title: 'Requerimento de Benefício por Incapacidade — on-line',
      description: 'Acesso ao pedido digital e ficha de conferência dos documentos médicos e dados do segurado.', template: 'benefit', type: 'Serviço on-line', issuer: 'INSS', updated: '20/08/2026', officialUrl: 'https://www.gov.br/pt-br/servicos/solicitar-beneficio-por-incapacidade-temporaria-auxilio-doenca', tags: 'incapacidade auxílio doença atestado perícia online'
    },
    {
      id: 'beneficio-incapacidade-formulario', category: 'Trabalhista / Previdenciário', title: 'Requerimento de Benefício por Incapacidade — formulário',
      description: 'Modelo digitável para organizar identificação, benefício e dados médicos.', template: 'benefit', type: 'Modelo preenchível', issuer: 'INSS', updated: '06/11/2025', officialUrl: INSS_FORMS, tags: 'incapacidade formulário atestado perícia'
    },
    {
      id: 'justificacao-administrativa', category: 'Trabalhista / Previdenciário', title: 'Requerimento de Justificação Administrativa',
      description: 'Relaciona fatos, início de prova material e testemunhas para procedimento administrativo.', template: 'justification', type: 'Modelo preenchível', issuer: 'INSS', updated: '06/11/2025', officialUrl: INSS_FORMS, tags: 'justificação administrativa testemunhas prova material'
    },
    {
      id: 'pensao-morte-urbana', category: 'Trabalhista / Previdenciário', title: 'Requerimento de Pensão por Morte Urbana — on-line',
      description: 'Acesso ao pedido digital e ficha de conferência do instituidor e dos dependentes.', template: 'benefit', type: 'Serviço on-line', issuer: 'INSS', updated: '20/08/2026', officialUrl: 'https://www.gov.br/pt-br/servicos/solicitar-pensao-por-morte-urbana', tags: 'pensão morte urbana dependente instituidor'
    },
    {
      id: 'salario-maternidade', category: 'Trabalhista / Previdenciário', title: 'Requerimento do Salário-Maternidade',
      description: 'Ficha de conferência para solicitação do salário-maternidade e documentos do evento.', template: 'benefit', type: 'Serviço on-line', issuer: 'INSS', updated: '20/08/2026', officialUrl: 'https://www.gov.br/pt-br/servicos/solicitar-salario-maternidade-urbano', tags: 'salário maternidade nascimento adoção guarda'
    },
    {
      id: 'averbacao-atividade-religiosa', category: 'Trabalhista / Previdenciário', title: 'Requerimento para Averbação de Tempo de Atividade Religiosa',
      description: 'Declara períodos de atividade religiosa e documentos de comprovação.', template: 'periods', type: 'Modelo preenchível', issuer: 'INSS', updated: '06/11/2025', officialUrl: INSS_FORMS, tags: 'averbação tempo atividade religiosa ministro confissão'
    },
    {
      id: 'residuo-beneficios', category: 'Trabalhista / Previdenciário', title: 'Solicitação de Pagamento de Resíduo de Benefícios',
      description: 'Solicita valores de benefício não recebidos até a data do óbito do titular.', template: 'benefit', type: 'Modelo preenchível', issuer: 'INSS', updated: '06/11/2025', officialUrl: INSS_FORMS, tags: 'resíduo benefício falecido herdeiro dependente'
    },
    {
      id: 'incapacidade-temporaria-online', category: 'Trabalhista / Previdenciário', title: 'Solicitar Benefício por Incapacidade Temporária — on-line',
      description: 'Direciona ao serviço oficial e permite preparar identificação e documentos médicos.', template: 'benefit', type: 'Serviço on-line', issuer: 'INSS', updated: '20/08/2026', officialUrl: 'https://www.gov.br/pt-br/servicos/solicitar-beneficio-por-incapacidade-temporaria-auxilio-doenca', tags: 'incapacidade temporária auxílio doença Atestmed'
    },
    {
      id: 'termo-responsabilidade-inss', category: 'Trabalhista / Previdenciário', title: 'Termo de Responsabilidade',
      description: 'Termo utilizado por representante para comunicar eventos que alterem a representação de beneficiários.', template: 'responsibility', type: 'PDF oficial e preenchimento', issuer: 'INSS', updated: '06/11/2025',
      officialUrl: 'https://www.gov.br/inss/pt-br/centrais-de-conteudo/publicacoes/outras/termo-de-responsabilidade.pdf/@@download/file', downloadUrl: 'https://www.gov.br/inss/pt-br/centrais-de-conteudo/publicacoes/outras/termo-de-responsabilidade.pdf/@@download/file', tags: 'termo responsabilidade procurador representante beneficiário'
    },
    {
      id: 'comprovante-rendimentos-pf', category: 'Federal', title: 'Comprovante de Rendimentos Pagos e de Imposto de Renda Retido na Fonte',
      description: 'Modelo de apoio para rendimentos pagos a pessoa física, contribuições, retenções e informações complementares.', template: 'earnings', type: 'Modelo preenchível', issuer: 'Receita Federal', updated: '20/08/2026', officialUrl: 'https://www.gov.br/receitafederal/pt-br/assuntos/noticias/2021/dezembro/aprovado-o-novo-modelo-de-comprovante-de-rendimentos-pagos-e-de-imposto-sobre-a-renda-retido-na-fonte', tags: 'comprovante rendimentos pessoa física IRRF'
    },
    {
      id: 'comprovante-rendimentos-pj', category: 'Federal', title: 'Comprovante Anual de Rendimentos Pagos ou Creditados e de Retenção de IRPJ',
      description: 'Organiza rendimentos pagos a pessoa jurídica e retenções na fonte durante o ano-calendário.', template: 'earnings-company', type: 'Modelo preenchível', issuer: 'Receita Federal', updated: '20/08/2026', officialUrl: RFB, tags: 'comprovante anual pessoa jurídica retenção IRPJ CSLL PIS Cofins'
    },
    {
      id: 'comprovante-propaganda', category: 'Federal', title: 'Comprovante Anual de Imposto de Renda Recolhido — Serviços de Propaganda e Publicidade',
      description: 'Relaciona valores faturados, imposto recolhido e beneficiários dos serviços de publicidade.', template: 'earnings-company', type: 'Modelo preenchível', issuer: 'Receita Federal', updated: '20/08/2026', officialUrl: RFB, tags: 'propaganda publicidade imposto renda comprovante agência anunciante'
    },
    {
      id: 'quitacao-anual-debitos', category: 'Federal', title: 'Declaração de Quitação Anual de Débitos',
      description: 'Declara a quitação das faturas de serviços do ano, nos termos da Lei nº 12.007/2009.', template: 'clearance', type: 'Modelo preenchível', issuer: 'Prestador de serviços', updated: '20/08/2026', officialUrl: 'https://www.planalto.gov.br/ccivil_03/_ato2007-2010/2009/lei/l12007.htm', tags: 'quitação anual débitos consumidor faturas Lei 12007'
    },
    {
      id: 'nota-promissoria', category: 'Federal', title: 'Nota Promissória',
      description: 'Modelo preenchível com valor, vencimento, emitente, beneficiário e local de pagamento.', template: 'promissory', type: 'Modelo preenchível', issuer: 'Partes privadas', updated: '20/08/2026', officialUrl: 'https://www.planalto.gov.br/ccivil_03/decreto/1930-1949/d57663.htm', tags: 'nota promissória título crédito vencimento beneficiário emitente'
    }
  ];

  window.GESTAO_FISCAL_FORMS = forms;
  window.GESTAO_FISCAL_FORMS_META = {
    checkedAt: '20/08/2026', count: forms.length,
    referenceUrl: 'https://www.econeteditora.com.br/links_pagina_inicial/fomularios/indice_formularios.php',
    disclaimer: 'Catálogo próprio. Links oficiais devem ser conferidos na data do uso; os modelos locais não substituem formulários oficiais obrigatórios.'
  };
}());
