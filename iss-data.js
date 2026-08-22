(function () {
  'use strict';

  window.ISS_SERVICE_GROUPS = {
    '1': 'Informática e congêneres',
    '2': 'Pesquisa e desenvolvimento',
    '3': 'Locação, cessão de uso e congêneres',
    '4': 'Saúde e assistência médica',
    '5': 'Medicina e assistência veterinária',
    '6': 'Cuidados pessoais, estética e atividades físicas',
    '7': 'Engenharia, construção, limpeza e meio ambiente',
    '8': 'Educação, ensino e treinamento',
    '9': 'Hospedagem, turismo e viagens',
    '10': 'Intermediação e congêneres',
    '11': 'Guarda, estacionamento, vigilância e armazenamento',
    '12': 'Diversões, lazer e entretenimento',
    '13': 'Fonografia, fotografia e reprografia',
    '14': 'Serviços relativos a bens de terceiros',
    '15': 'Setor bancário ou financeiro',
    '16': 'Transporte de natureza municipal',
    '17': 'Apoio técnico, administrativo, jurídico e contábil',
    '18': 'Regulação de sinistros e riscos seguráveis',
    '19': 'Loterias, apostas e sorteios',
    '20': 'Serviços portuários, aeroportuários e terminais',
    '21': 'Registros públicos, cartorários e notariais',
    '22': 'Exploração de rodovia',
    '23': 'Programação e comunicação visual',
    '24': 'Chaveiros, carimbos, placas e sinalização',
    '25': 'Serviços funerários',
    '26': 'Coleta, remessa ou entrega',
    '27': 'Assistência social',
    '28': 'Avaliação de bens e serviços',
    '29': 'Biblioteconomia',
    '30': 'Biologia, biotecnologia e química',
    '31': 'Serviços técnicos especializados',
    '32': 'Desenhos técnicos',
    '33': 'Desembaraço aduaneiro e despachantes',
    '34': 'Investigações particulares',
    '35': 'Reportagem, imprensa e relações públicas',
    '36': 'Meteorologia',
    '37': 'Artistas, atletas e modelos',
    '38': 'Museologia',
    '39': 'Ourivesaria e lapidação',
    '40': 'Obras de arte sob encomenda'
  };

  window.ISS_CAPITALS = [
    { uf: 'AC', city: 'Rio Branco', region: 'Norte', x: 13, y: 45, url: 'https://www.riobranco.ac.gov.br/' },
    { uf: 'AL', city: 'Maceió', region: 'Nordeste', x: 84, y: 45, url: 'https://maceio.al.gov.br/' },
    { uf: 'AP', city: 'Macapá', region: 'Norte', x: 58, y: 11, url: 'https://macapa.ap.gov.br/' },
    { uf: 'AM', city: 'Manaus', region: 'Norte', x: 32, y: 22, url: 'https://manausatende.manaus.am.gov.br/' },
    { uf: 'BA', city: 'Salvador', region: 'Nordeste', x: 77, y: 55, url: 'https://www.sefaz.salvador.ba.gov.br/' },
    { uf: 'CE', city: 'Fortaleza', region: 'Nordeste', x: 79, y: 27, url: 'https://www.sefin.fortaleza.ce.gov.br/' },
    { uf: 'DF', city: 'Brasília', region: 'Centro-Oeste', x: 60, y: 62, url: 'https://www.receita.fazenda.df.gov.br/' },
    { uf: 'ES', city: 'Vitória', region: 'Sudeste', x: 75, y: 72, url: 'https://www.vitoria.es.gov.br/semfa' },
    { uf: 'GO', city: 'Goiânia', region: 'Centro-Oeste', x: 56, y: 67, url: 'https://www.goiania.go.gov.br/sing_servicos/iss/' },
    { uf: 'MA', city: 'São Luís', region: 'Nordeste', x: 70, y: 24, url: 'https://www.saoluis.ma.gov.br/' },
    { uf: 'MT', city: 'Cuiabá', region: 'Centro-Oeste', x: 43, y: 61, url: 'https://www.cuiaba.mt.gov.br/' },
    { uf: 'MS', city: 'Campo Grande', region: 'Centro-Oeste', x: 45, y: 73, url: 'https://www.campogrande.ms.gov.br/' },
    { uf: 'MG', city: 'Belo Horizonte', region: 'Sudeste', x: 66, y: 71, url: 'https://prefeitura.pbh.gov.br/fazenda' },
    { uf: 'PA', city: 'Belém', region: 'Norte', x: 61, y: 20, url: 'https://www.belem.pa.gov.br/' },
    { uf: 'PB', city: 'João Pessoa', region: 'Nordeste', x: 87, y: 37, url: 'https://www.joaopessoa.pb.gov.br/secretarias/serem/' },
    { uf: 'PR', city: 'Curitiba', region: 'Sul', x: 55, y: 84, url: 'https://www.curitiba.pr.gov.br/conteudo/iss/175' },
    { uf: 'PE', city: 'Recife', region: 'Nordeste', x: 87, y: 40, url: 'https://recifeemdia.recife.pe.gov.br/' },
    { uf: 'PI', city: 'Teresina', region: 'Nordeste', x: 72, y: 31, url: 'https://semf.teresina.pi.gov.br/' },
    { uf: 'RJ', city: 'Rio de Janeiro', region: 'Sudeste', x: 68, y: 78, url: 'https://carioca.rio/servicos/iss/' },
    { uf: 'RN', city: 'Natal', region: 'Nordeste', x: 86, y: 32, url: 'https://www.natal.rn.gov.br/semut/' },
    { uf: 'RS', city: 'Porto Alegre', region: 'Sul', x: 48, y: 94, url: 'https://prefeitura.poa.br/smf' },
    { uf: 'RO', city: 'Porto Velho', region: 'Norte', x: 24, y: 46, url: 'https://www.portovelho.ro.gov.br/' },
    { uf: 'RR', city: 'Boa Vista', region: 'Norte', x: 33, y: 5, url: 'https://boavista.rr.gov.br/' },
    { uf: 'SC', city: 'Florianópolis', region: 'Sul', x: 58, y: 90, url: 'https://www.pmf.sc.gov.br/entidades/fazenda/' },
    { uf: 'SP', city: 'São Paulo', region: 'Sudeste', x: 59, y: 78, url: 'https://prefeitura.sp.gov.br/web/fazenda/w/servicos/iss' },
    { uf: 'SE', city: 'Aracaju', region: 'Nordeste', x: 83, y: 49, url: 'https://fazenda.aracaju.se.gov.br/' },
    { uf: 'TO', city: 'Palmas', region: 'Norte', x: 61, y: 48, url: 'https://www.palmas.to.gov.br/' }
  ];

  var raw = `
1.01|Análise e desenvolvimento de sistemas
1.02|Programação
1.03|Processamento, armazenamento ou hospedagem de dados, textos, imagens, vídeos, páginas, aplicativos e sistemas
1.04|Elaboração de programas de computadores e jogos eletrônicos
1.05|Licenciamento ou cessão de direito de uso de programas de computação
1.06|Assessoria e consultoria em informática
1.07|Suporte técnico em informática, instalação, configuração e manutenção
1.08|Planejamento, confecção, manutenção e atualização de páginas eletrônicas
1.09|Disponibilização de conteúdos de áudio, vídeo, imagem e texto pela internet
2.01|Pesquisa e desenvolvimento de qualquer natureza
3.02|Cessão de direito de uso de marcas e sinais de propaganda
3.03|Exploração de salões, centros de convenções, escritórios virtuais, stands, quadras, estádios, auditórios e espaços para eventos
3.04|Locação, sublocação, arrendamento, direito de passagem ou permissão de uso de ferrovia, rodovia, postes, cabos, dutos e condutos
3.05|Cessão de andaimes, palcos, coberturas e estruturas de uso temporário
4.01|Medicina e biomedicina
4.02|Análises clínicas, patologia, radioterapia, quimioterapia, ultrassonografia, ressonância, radiologia e tomografia
4.03|Hospitais, clínicas, laboratórios, sanatórios, casas de saúde, prontos-socorros e ambulatórios
4.04|Instrumentação cirúrgica
4.05|Acupuntura
4.06|Enfermagem e serviços auxiliares
4.07|Serviços farmacêuticos
4.08|Terapia ocupacional, fisioterapia e fonoaudiologia
4.09|Terapias destinadas ao tratamento físico, orgânico e mental
4.10|Nutrição
4.11|Obstetrícia
4.12|Odontologia
4.13|Ortóptica
4.14|Próteses sob encomenda
4.15|Psicanálise
4.16|Psicologia
4.17|Casas de repouso e recuperação, creches e asilos
4.18|Inseminação artificial e fertilização in vitro
4.19|Bancos de sangue, leite, pele, olhos, óvulos e sêmen
4.20|Coleta de sangue, leite, tecidos, sêmen, órgãos e materiais biológicos
4.21|Unidade móvel de atendimento, assistência ou tratamento
4.22|Planos de medicina e convênios de assistência médica, hospitalar e odontológica
4.23|Outros planos de saúde cumpridos por serviços de terceiros
5.01|Medicina veterinária e zootecnia
5.02|Hospitais, clínicas, ambulatórios e prontos-socorros veterinários
5.03|Laboratórios de análise veterinária
5.04|Inseminação artificial e fertilização in vitro veterinária
5.05|Bancos de sangue e órgãos veterinários
5.06|Coleta de materiais biológicos veterinários
5.07|Unidade móvel de atendimento veterinário
5.08|Guarda, tratamento, adestramento, embelezamento e alojamento de animais
5.09|Planos de atendimento e assistência médico-veterinária
6.01|Barbearia, cabeleireiros, manicuros e pedicuros
6.02|Esteticistas, tratamento de pele e depilação
6.03|Banhos, duchas, sauna e massagens
6.04|Ginástica, dança, esportes, natação, artes marciais e atividades físicas
6.05|Centros de emagrecimento e spa
6.06|Aplicação de tatuagens e piercings
7.01|Engenharia, agronomia, agrimensura, arquitetura, geologia, urbanismo e paisagismo
7.02|Execução de obras de construção civil, hidráulica, elétrica e semelhantes
7.03|Planos diretores, estudos e projetos de engenharia
7.04|Demolição
7.05|Reparação, conservação e reforma de edifícios, estradas, pontes e portos
7.06|Instalação de tapetes, carpetes, assoalhos, cortinas, revestimentos, vidros e divisórias
7.07|Recuperação, raspagem, polimento e lustração de pisos
7.08|Calafetação
7.09|Varrição, coleta, remoção, tratamento, reciclagem e destinação de resíduos
7.10|Limpeza, manutenção e conservação de vias, imóveis, piscinas, parques e jardins
7.11|Decoração e jardinagem, corte e poda de árvores
7.12|Controle e tratamento de efluentes e agentes físicos, químicos e biológicos
7.13|Dedetização, desinfecção, higienização, desratização e pulverização
7.16|Florestamento, reflorestamento, plantio, silagem, colheita, corte e exploração florestal
7.17|Escoramento e contenção de encostas
7.18|Limpeza e dragagem de rios, portos, canais, baías, lagos e represas
7.19|Acompanhamento e fiscalização de obras de engenharia, arquitetura e urbanismo
7.20|Aerofotogrametria, cartografia, mapeamento e levantamentos técnicos
7.21|Serviços relacionados à exploração de petróleo, gás e recursos minerais
7.22|Nucleação e bombardeamento de nuvens
8.01|Ensino regular pré-escolar, fundamental, médio e superior
8.02|Instrução, treinamento, orientação educacional e avaliação de conhecimentos
9.01|Hospedagem em hotéis, flats, apart-hotéis, motéis, pensões e similares
9.02|Agenciamento, organização, promoção, intermediação e execução de turismo e viagens
9.03|Guias de turismo
10.01|Intermediação de câmbio, seguros, cartões, planos de saúde e previdência privada
10.02|Intermediação de títulos, valores mobiliários e contratos
10.03|Intermediação de direitos de propriedade industrial, artística ou literária
10.04|Intermediação de leasing, franquia e factoring
10.05|Intermediação de bens móveis ou imóveis e operações em bolsas
10.06|Agenciamento marítimo
10.07|Agenciamento de notícias
10.08|Agenciamento de publicidade e veiculação
10.09|Representação de qualquer natureza, inclusive comercial
10.10|Distribuição de bens de terceiros
11.01|Guarda e estacionamento de veículos, aeronaves e embarcações
11.02|Vigilância, segurança ou monitoramento de bens, pessoas e semoventes
11.03|Escolta de veículos e cargas
11.04|Armazenamento, depósito, carga, descarga, arrumação e guarda de bens
11.05|Monitoramento e rastreamento a distância de veículos, cargas, pessoas e semoventes
12.01|Espetáculos teatrais
12.02|Exibições cinematográficas
12.03|Espetáculos circenses
12.04|Programas de auditório
12.05|Parques de diversões e centros de lazer
12.06|Boates e taxi-dancing
12.07|Shows, balé, danças, desfiles, bailes, óperas, concertos, recitais e festivais
12.08|Feiras, exposições e congressos
12.09|Bilhares, boliches e diversões eletrônicas ou não
12.10|Corridas e competições de animais
12.11|Competições esportivas ou de destreza física ou intelectual
12.12|Execução de música
12.13|Produção de eventos, espetáculos, entrevistas, shows e festivais
12.14|Fornecimento de música para ambientes por qualquer processo
12.15|Desfiles carnavalescos ou folclóricos e trios elétricos
12.16|Exibição de filmes, entrevistas, musicais, shows, concertos e competições
12.17|Recreação e animação em festas e eventos
13.02|Fonografia ou gravação de sons, trucagem, dublagem e mixagem
13.03|Fotografia e cinematografia, revelação, ampliação, cópia e reprodução
13.04|Reprografia, microfilmagem e digitalização
13.05|Composição e confecção de impressos gráficos, fotocomposição, clicheria, litografia e fotolitografia
14.01|Lubrificação, limpeza, revisão, recarga, conserto, restauração, blindagem e manutenção de bens
14.02|Assistência técnica
14.03|Recondicionamento de motores
14.04|Recauchutagem ou regeneração de pneus
14.05|Restauração, pintura, beneficiamento, lavagem, tingimento, galvanoplastia, corte, costura e polimento de objetos
14.06|Instalação e montagem de aparelhos, máquinas e equipamentos
14.07|Colocação de molduras
14.08|Encadernação, gravação e douração de livros e revistas
14.09|Alfaiataria e costura com material do usuário final
14.10|Tinturaria e lavanderia
14.11|Tapeçaria e reforma de estofamentos
14.12|Funilaria e lanternagem
14.13|Carpintaria e serralheria
14.14|Guincho intramunicipal, guindaste e içamento
15.01|Administração de fundos, consórcios, cartões, carteiras de clientes e cheques
15.02|Abertura e manutenção de contas, investimentos e poupança
15.03|Locação e manutenção de cofres, terminais e equipamentos bancários
15.04|Fornecimento ou emissão de atestados
15.05|Cadastro, ficha cadastral, renovação e registros cadastrais
15.06|Emissão de documentos, abono, coleta e entrega, comunicação, licenciamento e agenciamento fiduciário
15.07|Acesso, movimentação, atendimento e consulta a contas
15.08|Serviços relacionados a contratos e operações de crédito, aval e fiança
15.09|Arrendamento mercantil e serviços relacionados
15.10|Cobranças, recebimentos ou pagamentos, câmbio, tributos e serviços relacionados
15.11|Devolução, protesto, sustação e manutenção de títulos
15.12|Custódia de títulos e valores
15.13|Serviços relacionados a operações de câmbio
15.14|Fornecimento, emissão e manutenção de cartões
15.15|Compensação de cheques e títulos, depósitos e saques
15.16|Ordens de pagamento e crédito e transferência de valores e dados
15.17|Emissão, devolução, sustação, cancelamento e oposição de cheques
15.18|Serviços relacionados a crédito imobiliário
16.01|Transporte coletivo municipal de passageiros
16.02|Outros transportes de natureza municipal
17.01|Assessoria ou consultoria, análise, pesquisa e fornecimento de dados
17.02|Digitação, secretaria, redação, edição, interpretação, revisão, tradução e apoio administrativo
17.03|Planejamento, coordenação, programação ou organização técnica, financeira ou administrativa
17.04|Recrutamento, agenciamento, seleção e colocação de mão de obra
17.05|Fornecimento de mão de obra, inclusive temporária
17.06|Propaganda e publicidade, campanhas e materiais publicitários
17.08|Franquia
17.09|Perícias, laudos, exames e análises técnicas
17.10|Planejamento, organização e administração de feiras, exposições e congressos
17.11|Organização de festas, recepções e bufê
17.12|Administração em geral, inclusive de bens e negócios de terceiros
17.13|Leilão
17.14|Advocacia
17.15|Arbitragem
17.16|Auditoria
17.17|Análise de Organização e Métodos
17.18|Atuária e cálculos técnicos
17.19|Contabilidade e serviços técnicos e auxiliares
17.20|Consultoria e assessoria econômica ou financeira
17.21|Estatística
17.22|Cobrança em geral
17.23|Serviços relacionados a operações de factoring
17.24|Palestras, conferências e seminários
17.25|Inserção de publicidade em qualquer meio, observadas as exceções legais
18.01|Regulação de sinistros, inspeção e avaliação de riscos seguráveis
19.01|Distribuição e venda de loterias, bingos, apostas, sorteios e capitalização
20.01|Serviços portuários e ferroportuários, movimentação, armazenagem e logística
20.02|Serviços aeroportuários, movimentação, armazenagem e logística
20.03|Serviços de terminais rodoviários, ferroviários e metroviários
21.01|Registros públicos, cartorários e notariais
22.01|Exploração de rodovia mediante preço ou pedágio
23.01|Programação e comunicação visual e desenho industrial
24.01|Chaveiros, carimbos, placas, sinalização visual, banners e adesivos
25.01|Funerais e serviços relacionados
25.02|Translado intramunicipal e cremação de corpos
25.03|Planos ou convênios funerários
25.04|Manutenção e conservação de jazigos e cemitérios
25.05|Cessão de espaços em cemitérios para sepultamento
26.01|Coleta, remessa ou entrega de correspondências, documentos, objetos, bens ou valores
27.01|Assistência social
28.01|Avaliação de bens e serviços de qualquer natureza
29.01|Biblioteconomia
30.01|Biologia, biotecnologia e química
31.01|Serviços técnicos em edificações, eletrônica, eletrotécnica, mecânica e telecomunicações
32.01|Desenhos técnicos
33.01|Desembaraço aduaneiro, comissários e despachantes
34.01|Investigações particulares e detetives
35.01|Reportagem, assessoria de imprensa, jornalismo e relações públicas
36.01|Meteorologia
37.01|Artistas, atletas, modelos e manequins
38.01|Museologia
39.01|Ourivesaria e lapidação com material do tomador
40.01|Obras de arte sob encomenda
`;

  window.ISS_SERVICE_CATALOG = raw.trim().split('\n').map(function (line) {
    var parts = line.split('|');
    var code = parts.shift();
    var group = code.split('.')[0];
    return { code: code, group: group, groupName: window.ISS_SERVICE_GROUPS[group], description: parts.join('|') };
  });
}());
