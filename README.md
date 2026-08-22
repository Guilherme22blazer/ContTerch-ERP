# ContTech ERP

Plataforma responsiva de inteligência tributária inspirada fielmente na referência fornecida: cabeçalho verde em camadas, seletor de cliente, atalhos de salvar/importar/exportar, navegação horizontal, cartões, indicadores, tabelas e cálculo do DAS.

## Início rápido

### Opção 1 — banco SQLite (recomendada)

1. Tenha o Python 3.10 ou mais recente instalado.
2. No Windows, dê dois cliques em **ABRIR-MODO-SEGURO.cmd** (ou em **iniciar-site.cmd**).
3. Acesse http://127.0.0.1:4173.

Também é possível iniciar pelo terminal:

    python -m pip install -r requirements.txt
    python server.py

O banco é criado automaticamente em **data/simplescalc.db**. O inicializador instala o componente `cryptography`, utilizado para validar certificados A1 e cifrar certificados, senhas salvas, XMLs e resultados fiscais.

### Opção 2 — demonstração autocontida

Abra **index.html** diretamente apenas para visualizar a tela inicial. Por segurança, login, usuários, permissões e assinaturas exigem o modo servidor com banco SQLite; senhas nunca são mantidas no navegador.

## Acesso no pacote de hospedagem

As senhas públicas de demonstração não são válidas no pacote de produção. Os dados de acesso temporários estão no arquivo privado `ACESSO-INICIAL-PRIVADO.txt`, fora da pasta pública da aplicação. Troque as senhas antes de divulgar o endereço e apague esse arquivo do servidor após o primeiro acesso.

O administrador pode cadastrar, editar, excluir, importar, restaurar e atualizar o conteúdo legal. O usuário possui acesso de consulta e exportação.

## Recursos entregues

- Menu principal em barra lateral esquerda, com opções organizadas verticalmente, destaque da página ativa e versão recolhível para tablets e celulares.
- Módulo integrado de consultas fiscais com Consulta CNPJ, Inscrição Estadual, CNAE × Serviços, NCM/TIPI, CFOP, ICMS/DIFAL, NBS/cClassTrib, Calculadora Tributária e Consulta CNPJ Simples.
- Aba **Consulta SEFAZ e Portal do Contribuinte** com seletor de documento, validação de chave de 44 dígitos para NF-e/NFC-e/CT-e/MDF-e e de 50 dígitos para NFS-e Nacional, certificados A1 por empresa/filial, produção ou homologação, consultas oficiais, sincronização de documentos vinculados ao CNPJ pelo Ambiente Nacional da NF-e, histórico, filtros, auditoria, análise de XML, exportações e portais oficiais.
- Campos de CNPJ compatíveis com o formato numérico e com o CNPJ alfanumérico de 14 posições, incluindo máscara e validação oficial dos dígitos verificadores por módulo 11.
- Cálculo instantâneo do DAS para os Anexos I, II, III, IV e V: faturamento mensal e RBT12 atualizam, enquanto o usuário digita, o total, a faixa, as alíquotas, a fórmula, a partilha e os destaques de IBS/CBS.
- Simulação instantânea de Pró-Labore com INSS, IRRF, deduções, redução da Lei nº 15.270/2025 e parâmetros oficiais vigentes em 2026.
- Simulação instantânea da folha: quantidade de empregados × salário médio, FGTS de 8% e total atualizado enquanto o usuário digita.
- Aba **Horas Extras e Trabalho Noturno** com cálculo instantâneo para mensalistas e horistas, empregados urbanos e rurais, horas extras em dias úteis ou folgas/feriados, adicional noturno, conversão da hora urbana de 52min30s, horas extras noturnas e reflexo no descanso semanal. Os percentuais são editáveis para normas coletivas e o módulo inclui memória completa, alertas, salvamento, JSON e impressão/PDF.
- Aba **Seguro-Desemprego** com cálculo instantâneo da média dos três últimos salários, parcela, piso e teto de 2026, quantidade de 3 a 5 parcelas, carência da 1ª, 2ª ou 3ª solicitação, conferência dos requisitos, memória de cálculo, salvamento, JSON e impressão/PDF.
- Aba **GPS — INSS em Atraso** com cálculo instantâneo do principal, multa de 0,33% ao dia limitada a 20%, juros Selic, valor total, memória mensal das taxas, códigos usuais, validação dos limites do contribuinte individual e facultativo, alertas de DARF/DCTFWeb, salvamento, JSON e impressão/PDF. A emissão oficial permanece no SAL/Meu INSS.
- Aba **Alíquota Efetiva do IRRF** com cálculo instantâneo da base mensal, comparação automática entre deduções legais e desconto simplificado, tabela progressiva de 2026, redução da Lei nº 15.270/2025, dispensa de retenção até R$ 10,00, alíquotas nominal e efetiva, memória completa, salvamento, JSON e impressão/PDF.
- Aba **Análise de Balanço** com estrutura completa de Ativo, Passivo, Patrimônio Líquido e dados da DRE, conferência automática da equação patrimonial, capital de giro e 13 indicadores de liquidez, endividamento, solvência, atividade e rentabilidade. O módulo calcula enquanto o usuário digita, identifica inconsistências entre grupos e subcontas, gera diagnóstico executivo, memória das fórmulas, salvamento, JSON e impressão/PDF.
- Aba **Transição da Reforma Tributária** com preenchimento manual ou leitura de múltiplos XMLs, comparação entre tributos atuais e IBS/CBS/IS, créditos, carga efetiva, impacto na margem, memória de cálculo, relatório JSON e cronograma interativo de 2026 a 2033. As alíquotas de referência são editáveis e o resultado deve ser conferido com a legislação e o enquadramento da operação.
- Menu lateral separado em **Área Fiscal**, **Área Contábil**, **Área Trabalhista** e **Outros**, com grupos recolhíveis e abertura automática da área correspondente à página ativa.
- Aba **Quadro Kanban** com quatro etapas, criação e edição de blocos, prioridade, responsável, cliente, prazo, exclusão, movimentação por arrastar ou pelo seletor no celular, persistência, auditoria e exportação JSON.
- Aba **Controle de MEI** baseada na planilha financeira enviada, com cadastro, edição e exclusão de receitas e despesas, taxas de meios de pagamento, valor líquido instantâneo, filtros por cliente/ano/mês, fluxo mensal de 12 meses, dashboard, gráficos de receitas, despesas e saldo, análises por categoria, persistência, auditoria, backup e exportações JSON/CSV.
- Página inicial **Visão Geral da Carteira** após o login, com indicadores consolidados, faturamento RBT12, riscos, obrigações, tarefas e prazos do Kanban, distribuição por regime, andamento por etapa e cartões completos de cada cliente. O andamento individual pode ser atualizado com etapa, percentual, próximo passo, prazo e observações.
- Aba **Alíquotas do ISS** com mapa político real do Brasil baseado na malha territorial do IBGE, limites das 27 unidades federativas, nomes e seleção das 27 capitais, os 200 subitens vigentes da lista da LC nº 116/2003, pesquisa por código/atividade, filtros por grupo, estimativa instantânea do imposto, exportação JSON e acesso ao portal oficial de cada município. A alíquota municipal exata deve ser validada na legislação local.
- Aba **Consulta CEST** com 1.051 registros dos anexos do Convênio ICMS 142/2018, pesquisa instantânea por NCM, CEST ou descrição, filtros pelos 25 segmentos, mercadorias sem NCM e venda porta a porta, paginação, detalhes, exportação JSON/CSV e links oficiais. O resultado deve ser cruzado com a descrição da mercadoria e a legislação da UF.
- Diagnóstico tributário por cliente, pontuação de risco, alertas e relatório exportável.
- Cadastro, edição, exclusão, pesquisa e filtros de clientes.
- Consulta de CNPJ dentro do cadastro de clientes, com preenchimento automático de razão social, nome fantasia, situação cadastral, abertura, CNAE principal e secundários, natureza jurídica, porte, capital social, endereço, CEP, e-mail e telefone. O resultado é identificado pela fonte, recebe data e hora, usa cache de curta duração para respostas rápidas e nunca substitui faturamento, responsável ou observações internas.
- Prevenção de duplicidade por CPF/CNPJ.
- Importação JSON com validação e confirmação antes de substituir registros.
- Exportação de toda a base ou de um cliente individual.
- Backup completo e restauração com confirmação.
- Página individual por cliente com cadastro, regime, CNAE, faturamento, obrigações e histórico.
- Conteúdo de MEI, Simples Nacional, IBS/CBS, Reforma Tributária e obrigações.
- Biblioteca legal com norma, órgão, publicação, atualização e link oficial.
- Painel administrativo para atualização manual do conteúdo legal.
- Parâmetros 2026, cronologia da transição e alertas legais.
- Login com perfis de administrador e usuário.
- Vídeo de apresentação exclusivo no login, com reprodução automática silenciosa, adaptação responsiva e pausa após o acesso.
- Gestão de usuários e assinaturas com cobrança mensal, trimestral ou anual, valor, vigência, próximo vencimento, dias restantes e acompanhamento percentual.
- Banco SQLite opcional, sessão autenticada e cópia local de contingência.
- Pesquisa global, dashboard, auditoria, mensagens e layout responsivo.

## Importação JSON

Use **exemplo-importacao.json** como modelo. Também são aceitos:

- um array de clientes;
- um objeto com a propriedade clients;
- um cadastro individual exportado pelo próprio sistema.

Campos mínimos: name, document e regime. O documento precisa conter 11 dígitos para CPF ou 14 para CNPJ. A validação estrutural não substitui a consulta de situação cadastral na Receita Federal.

## Consulta de CNPJ no cadastro de clientes

Abra **Clientes → Novo cliente**, informe um CNPJ válido e clique em **Consultar e preencher**. No modo seguro, a consulta passa pelo servidor local, utiliza cache por 15 minutos e tenta as fontes disponíveis sem expor credenciais no navegador. Ao editar um cadastro preenchido, a plataforma pede confirmação antes de substituir os campos cadastrais.

A integração direta e em tempo real com a base da Receita Federal é o serviço contratado **API Consulta CNPJ do SERPRO**. Depois da contratação, defina no ambiente seguro do servidor:

    SERPRO_CNPJ_CONSUMER_KEY=sua_consumer_key
    SERPRO_CNPJ_CONSUMER_SECRET=seu_consumer_secret

As credenciais nunca devem ser inseridas no HTML ou salvas no navegador. Quando elas não estão configuradas, a plataforma usa fontes públicas de espelhamento do CNPJ, identifica essa condição na tela e mantém um botão para conferência no serviço oficial da Receita/REDESIM.

## Backup e restauração

Em **Clientes** ou **Configurações**:

1. Clique em **Gerar backup completo**.
2. Guarde o JSON em local protegido.
3. Para restaurar, clique em **Restaurar backup** e selecione o arquivo.
4. Confirme a substituição da base atual.

No modo SQLite, faça também cópia protegida do arquivo **data/simplescalc.db** com o servidor desligado.

## Atualização do conteúdo legal

Entre como administrador e acesse **Configurações → Atualização manual do conteúdo legal**. Informe título, número, órgão, publicação, atualização, resumo e o link oficial. O registro passa a aparecer na biblioteca e no histórico.

Rotina sugerida:

1. Verifique Receita Federal, Portal do Simples Nacional, CGSN, Portal do Empreendedor, Ministério da Fazenda, DOU, Planalto, CGIBS e portais de documentos fiscais.
2. Leia o ato e confirme vigência, produção de efeitos e eventuais versões compiladas.
3. Registre a data da última conferência.
4. Mantenha evidência da revisão e valide o conteúdo com profissional habilitado.

## Usuários, assinaturas e monitoramento

Entre como administrador e acesse **Outros → Gestão de Usuários**. A área é protegida no backend e reúne dashboard, pesquisa, filtros, tabela completa, perfis individuais, planos, permissões por módulo, assinaturas e auditoria.

O cadastro inclui dados pessoais e empresariais, login, perfil, status, plano, valor, período da assinatura, observações e módulos liberados. Ao selecionar um plano, as permissões são carregadas automaticamente e podem ser ajustadas por usuário. Senhas são armazenadas somente como hash PBKDF2 com salt; redefinições encerram as sessões anteriores.

O servidor verifica vencimentos automaticamente, limita usuários vencidos ao dashboard, bloqueia contas após tentativas repetidas, registra último login e IP quando disponível e nega no backend o acesso a módulos não autorizados. Planos e usuários permanecem no banco **data/simplescalc.db**, separados do estado local da interface para não serem sobrescritos por atualizações da página.

Planos comerciais disponíveis no cadastro de usuários:

| Plano | Mensal | Anual |
| --- | ---: | ---: |
| ERP Start | R$ 197,00 | R$ 1.970,00 |
| ERP Profissional ⭐ | R$ 397,00 | R$ 3.970,00 |
| ERP Business | R$ 697,00 | R$ 6.970,00 |
| ERP Enterprise | R$ 1.297,00 | R$ 12.970,00 |

Ao selecionar o plano e a periodicidade no cadastro, o sistema preenche automaticamente o valor correspondente; no ciclo trimestral, utiliza três mensalidades. O plano contratado também aparece na tabela e no perfil completo de cada usuário.

### Autocadastro pela página inicial

Na tela de acesso, selecione **Inscreva-se agora**. O formulário solicita responsável, razão social, e-mail, WhatsApp, CPF ou CNPJ, segmento, atividade, plano, periodicidade, senha e aceite dos termos. CPF, CNPJ, duplicidade, confirmação de senha e campos obrigatórios são verificados antes da gravação.

O valor do contrato é definido no servidor a partir do plano selecionado, sem confiar no valor enviado pela página. A conta recebe os módulos do plano, inicia o período de avaliação correspondente e entra automaticamente na plataforma após o cadastro. A operação fica registrada na auditoria.

### Recuperação da própria senha

Na tela de acesso, selecione **Esqueci minha senha**. O usuário confirma o e-mail, CPF/CNPJ e WhatsApp exatamente como foram cadastrados e, após a validação, define a nova senha dentro do próprio site. A autorização temporária dura 10 minutos, funciona uma única vez, possui limite de tentativas e não fica salva no navegador.

Quando a alteração é concluída, o servidor protege a nova senha com novo salt e hash, zera tentativas anteriores, desbloqueia contas bloqueadas por erro de senha, encerra as sessões antigas e registra a redefinição na auditoria. Contas sem CPF/CNPJ e telefone cadastrados devem primeiro ter esses dados preenchidos pelo administrador.

## Consulta SEFAZ e certificado digital

Essa função exige o modo servidor. Ela fica bloqueada quando `index.html` é aberto diretamente, pois o certificado e a senha nunca devem ser processados pelo frontend.

Se aparecer `ERR_CONNECTION_REFUSED`, “Failed to fetch” ou “Servidor seguro não encontrado”, significa que a janela do servidor não está aberta. Execute **ABRIR-MODO-SEGURO.cmd**, aguarde a mensagem **MODO SEGURO ATIVO** e mantenha a janela aberta. A plataforma será aberta automaticamente em `http://127.0.0.1:4173/#sefaz-portal`.

1. Inicie pelo arquivo **ABRIR-MODO-SEGURO.cmd**.
2. Entre como administrador e abra **Consulta SEFAZ e Portal do Contribuinte**.
3. Cadastre o certificado A1 `.pfx` ou `.p12`, a empresa, a filial, a UF e o ambiente.
4. Deixe desmarcada a opção de salvar a senha para mantê-la somente na memória da sessão. Se optar por salvar, a senha será cifrada no backend.
5. Escolha o tipo de documento. Para NF-e/NFC-e/CT-e/MDF-e informe a chave de 44 dígitos; para NFS-e de padrão nacional informe a chave de 50 dígitos.
6. Selecione o certificado e consulte. A NFS-e Nacional é obtida pela API oficial da SEFIN Nacional com autenticação mútua do A1; o atalho de consulta pública copia a chave e abre o portal oficial.
7. Anexe o XML autorizado quando precisar comparar um arquivo local. Para os documentos estaduais, o webservice de situação normalmente retorna status e protocolo, não o XML integral.

O resultado da NFS-e é apresentado em uma única tela seguindo a organização do DANFSe/Painel Nacional: dados da NFS-e e da DPS, prestador, tomador, serviço, tributação municipal, retenções federais, IBS/CBS, totais, eventos, informações complementares, XML, análise e rastreabilidade. Campos que não existirem no XML oficial aparecem como não informados; a plataforma não preenche dados fiscais por estimativa. Consultas antigas com XML arquivado também recebem esse espelho ampliado ao serem abertas novamente.

A consulta automática de NFS-e cobre o **padrão nacional**. Notas emitidas em sistemas municipais legados podem ter chave e serviço próprios e devem ser consultadas no portal da prefeitura responsável.

Para localizar notas vinculadas ao CPF/CNPJ do certificado, use **Notas fiscais vinculadas ao certificado → Sincronizar notas agora**. A sincronização usa o webservice oficial `NFeDistribuicaoDFe`, avança pelo último NSU recebido e guarda os XMLs cifrados. O serviço retorna somente documentos nos quais o titular do certificado é ator autorizado; ele não é uma pesquisa pública de notas de terceiros. Se o painel indicar que ainda há NSUs pendentes, sincronize novamente após processar o lote atual, respeitando os limites do Ambiente Nacional.

### Lote mensal de XML

1. Para documentos estaduais, execute **Sincronizar notas agora**.
2. Para um mês completo de NFS-e emitidas, baixe os XMLs oficiais do período no **Portal Nacional da NFS-e** ou no sistema municipal responsável. Em **Lote mensal de XML**, escolha a empresa e o mês, confirme que selecionou todos os documentos do período, clique em **Importar XMLs/ZIP oficiais** e selecione todos os XMLs de uma vez ou um ZIP que os reúna.
3. A plataforma confere o CPF/CNPJ do certificado (aceitando filiais da mesma raiz), o ambiente, a emissão/competência, os eventos de cancelamento, os arquivos repetidos e a estrutura de cada XML. O pacote e a senha do A1 não são enviados a terceiros.
4. Mantenha marcada a opção **Exigir pacote oficial validado** e clique em **Gerar lote completo do mês**. Para exportar somente os XMLs que já estão no arquivo seguro, desmarque essa opção.

O arquivo separa os XMLs nas pastas `emitidas`, `canceladas`, `recebidas` e `relacionadas` e inclui um `manifesto.json` com filtros, contagens, origem e hash SHA-256 de cada documento. O mês é determinado pela data de emissão ou competência. Quando um evento de cancelamento está associado a uma nota emitida já arquivada, ele acompanha o mês da nota original. XMLs duplicados são eliminados automaticamente.

O ZIP contém somente documentos reais retornados por serviço oficial ou importados do pacote oficial e guardados de forma cifrada; a plataforma não fabrica XMLs ausentes. O manifesto registra se a cobertura de NFS-e foi confirmada por pacote mensal, o nome do arquivo-fonte, a data da importação e os hashes SHA-256.

A API de contribuintes do ADN permite consultar documentos nos quais o certificado figure como emitente, tomador ou intermediário. O manual atual descreve consulta pontual por NSU e consulta de eventos por chave, mas não descreve uma exportação fechada por mês. Por isso, a plataforma exige que os XMLs oficiais do período sejam importados quando a opção de cobertura completa estiver marcada. Notas de municípios que ainda utilizam sistemas legados podem depender do portal da prefeitura.

Por padrão, a chave mestra local é criada em `data/.gestao-fiscal.key`. Em produção, não utilize esse arquivo: defina `GESTAOFISCAL_MASTER_KEY` no cofre de segredos do servidor e mantenha a chave separada do banco e dos backups. A variável deve conter uma chave Fernet válida.

As permissões fiscais são independentes: consultar documentos, administrar certificados, visualizar dados sensíveis, baixar XML, exportar relatórios, consultar histórico e administrar empresas/filiais. O administrador pode alterá-las dentro da própria aba.

Quando o serviço oficial estiver indisponível, rejeitar o certificado ou exigir consulta pública com desafio de segurança, o sistema registra a tentativa real e direciona para o portal oficial; não gera um resultado fictício.

Na primeira execução, o inicializador instala `cryptography` 49.x, versão compatível com o Python 3.14 no Windows. Se a instalação falhar, a janela informa o problema e não abre uma porta vazia no navegador. Verifique internet, proxy e firewall e execute o inicializador novamente.

## Lançamentos Contábeis

A aba **Lançamentos Contábeis** contém uma biblioteca própria com 97 modelos orientativos e cobertura das letras A a Z. Use **Apresentação**, clique em uma letra ou abra **Busca** para pesquisar por título, conta, categoria ou assunto. Os filtros por categoria, aplicação e favoritos funcionam em conjunto.

Ao abrir um modelo, informe o valor do exemplo para atualizar débito e crédito instantaneamente. O lançamento pode ser copiado, salvo nos favoritos ou exportado individualmente em JSON. **Exportar biblioteca** salva o resultado filtrado e suas referências. Administradores podem usar **Novo lançamento** para criar modelos próprios; esses registros e os favoritos ficam no armazenamento persistente da plataforma e também entram no backup geral.

Os nomes de contas e históricos são sugestões. Antes da escrituração definitiva, adapte o modelo ao plano de contas, à documentação, ao regime tributário e às políticas da entidade. A biblioteca foi inspirada apenas na organização alfabética indicada pelo usuário e não copia o conteúdo proprietário do portal de referência.

## Central de Formulários

A aba **Central de Formulários** reúne 25 documentos organizados em **Trabalhista / Previdenciário** e **Federal**. É possível pesquisar, filtrar por tipo, favoritar, preencher, salvar rascunhos, baixar individualmente em DOC, imprimir em PDF e gerar um pacote consolidado com os modelos da pesquisa atual.

Os formulários preenchíveis são modelos próprios de apoio. Cada item mantém um acesso separado à fonte oficial do INSS, Meu INSS, ANPD, Receita Federal ou legislação correspondente. Quando existir PDF oficial de download direto — como CAT, PPP e Termo de Responsabilidade — o catálogo também exibe **Baixar oficial**. Antes de protocolar, confirme no órgão a versão e o canal vigentes.

Os rascunhos permanecem no armazenamento persistente da plataforma e são incluídos no backup geral. Evite preencher dados pessoais em computadores públicos ou compartilhados.

## Modelos e Contratos

A aba **Modelos e Contratos** reúne 202 modelos próprios organizados em **Contratos Trabalhistas** (66), **Contratos Comerciais** (66) e **Contratos Societários** (70). A biblioteca permite pesquisa instantânea, filtro por assunto, favoritos, paginação, criação de modelos internos e exportação do catálogo em JSON.

Cada modelo possui preenchimento guiado da qualificação das partes, objeto, valores, vigência, condições específicas, foro, assinaturas e testemunhas. Todas as cláusulas são editáveis; o usuário pode salvar o rascunho, baixar o documento em DOC ou abrir a visualização de impressão para gerar PDF. Os rascunhos, favoritos e modelos internos usam o armazenamento persistente da plataforma e integram o backup geral.

A divisão em três áreas acompanha a organização visual indicada pelo usuário, mas os textos são originais e não reproduzem modelos proprietários do portal de referência. Os modelos usam referências oficiais, como CLT, Código Civil, legislação especial e manuais do DREI. Eles são orientativos e precisam de revisão jurídica, adequação ao caso concreto e conferência de exigências de assinatura, registro e tributação antes do uso.

## Pensão Alimentícia

A aba **Pensão Alimentícia** calcula imediatamente o valor mensal fixado em percentual sobre o rendimento líquido, percentual sobre o rendimento bruto ou valor fixo. A simulação aplica a tabela progressiva do INSS para empregados vigente em 2026, a tabela mensal do IRRF, a dedução por dependente, a redução da Lei nº 15.270/2025 e, quando marcada, a dedução da própria pensão juridicamente comprovada.

Quando o percentual incide sobre o líquido e a pensão também é dedutível do IRRF, o sistema resolve conjuntamente a pensão e o imposto até chegar a um resultado convergente. A tela apresenta a memória completa, alertas, saldo depois dos descontos, salvamento persistente, exportação em JSON e relatório para impressão ou PDF.

O cálculo deve seguir exatamente a decisão judicial, o acordo homologado ou a escritura pública válida. A ferramenta não interpreta o título nem presume quais verbas integram a base, especialmente férias, 13º salário, horas extras, verbas rescisórias e outros descontos.

## Fontes oficiais incorporadas

- [CNPJ Alfanumérico — Receita Federal](https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/acoes-e-programas/programas-e-atividades/cnpj-alfanumerico)
- [Documentação técnica do cálculo do DV do CNPJ](https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/publicacoes/documentos-tecnicos/cnpj)
- [Lei Complementar nº 123/2006](https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp123.htm)
- [Lei Complementar nº 116/2003 — ISS e lista de serviços](https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp116.htm)
- [Lei Complementar nº 157/2016 — alíquota mínima do ISS](https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp157.htm)
- [Convênio ICMS 142/2018 — CEST e Substituição Tributária](https://www.confaz.fazenda.gov.br/legislacao/convenios/2018/CV142_18)
- [Emenda Constitucional nº 132/2023](https://www.planalto.gov.br/ccivil_03/constituicao/emendas/emc/emc132.htm)
- [Lei Complementar nº 214/2025 — texto compilado](https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp214compilado.htm)
- [Lei Complementar nº 227/2026](https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp227.htm)
- [Resolução CGSN nº 140/2018 — compilada](https://normas.receita.fazenda.gov.br/sijut2consulta/link.action?idAto=92278&visao=compilado)
- [Orientações da Reforma Tributária para 2026](https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/acoes-e-programas/programas-e-atividades/reforma-tributaria-do-consumo/orientacoes-2026)
- [Documentos vigentes da NF-e](https://www.nfe.fazenda.gov.br/portal/listaConteudo.aspx?tipoConteudo=6WfrpZYE4Ik%3D)
- [Relação oficial de webservices da NF-e](https://www.nfe.fazenda.gov.br/portal/WebServices.aspx)
- [Portal oficial do CT-e](https://www.cte.fazenda.gov.br/portal/)
- [Portal oficial do MDF-e — SVRS](https://dfe-portal.svrs.rs.gov.br/MDFE)
- [Portal Nacional da NFS-e](https://www.gov.br/nfse/pt-br)
- [Manual de Contribuintes — APIs do ADN da NFS-e](https://www.gov.br/nfse/pt-br/biblioteca/documentacao-tecnica/documentacao-atual/manual-contribuintes-apis-adn-sistema-nacional-nfse.pdf)
- [Prazo da DASN-SIMEI](https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/perguntas-frequentes/dasn-simei-declaracao/qual-e-o-prazo-de)
- [MTE/FAT — reajuste do Seguro-Desemprego em 2026](https://portalfat.trabalho.gov.br/mte-reajusta-valores-do-beneficio-seguro-desemprego/)
- [MTE — Seguro-Desemprego Formal](https://www.gov.br/trabalho-e-emprego/pt-br/servicos/trabalhador/seguro-desemprego/seguro-desemprego-formal)
- [Lei nº 7.998/1990 — texto compilado](https://www.planalto.gov.br/ccivil_03/leis/l7998compilado.htm)
- [Receita Federal — incidência de acréscimos legais na GPS](https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/pagamentos-e-parcelamentos/emissao-e-pagamento-de-darf-das-gps-e-dae/gps-guia-da-previdencia-social-orientacoes-1/incidencia-de-acrescimos-legais)
- [Sicalc — consulta oficial da taxa Selic](https://sicalc.receita.fazenda.gov.br/sicalc/selic/consulta)
- [INSS — cálculo da Guia da Previdência Social](https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/calculo-da-guia-da-previdencia-social-gps)
- [INSS — regularização de contribuição previdenciária](https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/regularizacao-de-contribuicao-previdenciaria)
- [Receita Federal — tabela mensal do IRPF/IRRF de 2026](https://www.gov.br/receitafederal/pt-br/assuntos/meu-imposto-de-renda/tabelas/2026)
- [Receita Federal — exemplos de aplicação da Lei nº 15.270/2025](https://www.gov.br/receitafederal/pt-br/assuntos/meu-imposto-de-renda/tabelas/exemplos-de-aplicacao-da-lei-15-270-2025)
- [Lei nº 15.191/2025 — tabela progressiva mensal](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15191.htm)
- [Lei nº 15.270/2025 — redução mensal do imposto](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15270.htm)
- [Lei nº 9.430/1996 — art. 67, dispensa de retenção](https://www.planalto.gov.br/ccivil_03/leis/l9430.htm)
- [Lei nº 6.404/1976 — demonstrações financeiras e Balanço Patrimonial](https://www.planalto.gov.br/ccivil_03/leis/l6404consol.htm)
- [CPC 26 (R1) — Apresentação das Demonstrações Contábeis](https://www.cpc.org.br/CPC/Documentos-Emitidos/Pronunciamentos/Pronunciamento?Id=57)
- [CPC 00 (R2) — Estrutura Conceitual para Relatório Financeiro](https://www.cpc.org.br/Arquivos/Documentos/573_CPC00(R2).pdf)
- [CFC — Normas simplificadas para PMEs](https://portalrestore.cfc.org.br/tecnica/normas-brasileiras-de-contabilidade/normas-simplificadas-para-pmes/)
- [CFC — perguntas frequentes sobre Normas Brasileiras de Contabilidade](https://cfc.org.br/tecnica/perguntas-frequentes/normas-brasileiras-de-contabilidade/)
- [INSS — formulários para serviços e benefícios](https://www.gov.br/inss/pt-br/centrais-de-conteudo/formularios/formularios)
- [Meu INSS — requerimentos e serviços on-line](https://meu.inss.gov.br/)
- [ANPD — comunicação de incidente de segurança](https://www.gov.br/anpd/pt-br/canais_atendimento/agente-de-tratamento/comunicado-de-incidente-de-seguranca-cis)
- [Receita Federal — comprovante de rendimentos](https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/perguntas-frequentes/imposto-de-renda/dirpf/servicos/como-faco-para-obter-meu)
- [Lei nº 12.007/2009 — declaração de quitação anual de débitos](https://www.planalto.gov.br/ccivil_03/_ato2007-2010/2009/lei/l12007.htm)
- [CLT — arts. 59 e 73, horas extras e trabalho noturno](https://www.planalto.gov.br/ccivil_03/decreto-lei/del5452compilado.htm)
- [Lei nº 5.889/1973 — trabalho noturno rural](https://www.planalto.gov.br/ccivil_03/leis/l5889.htm)
- [TST — Súmulas 60, 172 e 264](https://www.tst.jus.br/documents/d/guest/livrointernet-12-pdf)
- [CLT — texto compilado](https://www.planalto.gov.br/ccivil_03/decreto-lei/del5452compilado.htm)
- [Código Civil — Lei nº 10.406/2002](https://www.planalto.gov.br/ccivil_03/leis/2002/l10406compilada.htm)
- [DREI — Instruções Normativas e manuais de registro](https://www.gov.br/empresas-e-negocios/pt-br/drei/legislacao/instrucoes-normativas)
- [Manual de Registro de Sociedade Limitada — DREI](https://www.gov.br/empresas-e-negocios/pt-br/drei/legislacao/instrucoes-normativas/arquivos-instrucoes-normativas-em-vigor/anexo-iv-limitada_compilada.pdf/@@download/file)
- [LGPD — Lei nº 13.709/2018](https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709compilado.htm)
- [Receita Federal — Tributação do IRPF em 2026](https://www.gov.br/receitafederal/pt-br/assuntos/meu-imposto-de-renda/tabelas/2026)
- [INSS — Tabela de contribuição mensal de 2026](https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/tabela-de-contribuicao-mensal)
- [Receita Federal — Dedução da pensão alimentícia](https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/perguntas-frequentes/imposto-de-renda/dirpf/deducoes/despesa-de-pensao-alimenticia)
- [Receita Federal — Conferência da pensão alimentícia](https://www.gov.br/receitafederal/pt-br/assuntos/meu-imposto-de-renda/malha-fiscal/antecipacao/pensao-alimenticia)
- [Código de Processo Civil — Lei nº 13.105/2015](https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2015/lei/l13105.htm)

A base foi conferida em 20/08/2026. O sistema não deve ser usado como parecer jurídico ou tributário sem validação das fontes vigentes e dos dados do contribuinte.

## Configuração para produção

Antes de publicar para uso real:

1. Altere as credenciais demonstrativas e implemente recuperação de senha e autenticação multifator.
2. Use HTTPS e coloque o serviço atrás de um proxy reverso.
3. Substitua a chave/sessão local por um provedor de identidade ou sessões persistidas com rotação.
4. Use PostgreSQL ou outro banco gerenciado para múltiplos usuários e concorrência.
5. Criptografe backups, defina retenção, registro de consentimento, bases legais e atendimento aos direitos dos titulares.
6. Adicione validação oficial de CNPJ/CPF somente por integração autorizada.
7. Implemente monitoramento, política de incidentes, testes automatizados e revisão de segurança.
8. Restrinja acesso ao painel administrativo e às exportações.
9. Configure `GESTAOFISCAL_MASTER_KEY` em um cofre de segredos, sem gravá-la no repositório ou no mesmo backup do banco.
10. Libere a saída HTTPS do backend somente para os domínios oficiais necessários e monitore rejeições, limites e indisponibilidades.

## Publicação

O front-end (index.html, styles.css e app.js) pode ser hospedado estaticamente apenas para demonstração. A consulta SEFAZ, os certificados, os XMLs, as permissões e a auditoria exigem o backend Python em HTTPS e armazenamento persistente.

Para uma publicação corporativa, recomenda-se separar o front-end da API, usar banco gerenciado e configurar as variáveis SIMPLESCALC_HOST (padrão 127.0.0.1) e SIMPLESCALC_PORT (padrão 4173).

Não publique o arquivo SQLite nem backups em diretório acessível pela web. Um proxy de produção deve negar explicitamente o caminho /data.
