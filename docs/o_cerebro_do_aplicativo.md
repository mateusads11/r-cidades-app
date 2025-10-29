---

### **Entendendo as Conexões do Nosso Banco de Dados (v3.0 Híbrido): O Cérebro do Aplicativo R+Cidades**

Pessoal, nosso diagrama do banco de dados é a planta baixa final do R+Cidades. As linhas que conectam as tabelas são o sistema nervoso. Elas dão vida à estrutura, impõem as regras do nosso modelo híbrido (Marketplace P2P \+ Banco de Materiais) e definem as funcionalidades que estamos a construir no protótipo navegável.

Vamos analisar cada conexão chave e o que ela significa na prática para o nosso app.

#### **1\. O Núcleo: usuarios e Suas Funções**

A tabela usuarios continua central, mas agora com papéis mais definidos e um processo de validação crucial.

* **Conexões Principais:** usuarios conecta-se a anuncios (como Doador), solicitacoes (como Beneficiário), agendamentos\_logistica (como Transportador ou Beneficiário/Doador na confirmação) e bancos\_de\_materiais (como Admin responsável).  
* **O que significa:** Cada ação no app (anunciar, solicitar, transportar) está ligada a um usuário específico. O tipo\_usuario ('Doador\_PF', 'Doador\_PJ', 'Beneficiario', 'Transportador', 'Admin') define o que cada um pode ver e fazer.  
* **Utilidade no App (Protótipo):**  
  * **Perfis Diferenciados:** Permite criar telas e fluxos distintos para cada tipo de usuário no login/cadastro.  
  * **Validação de Beneficiários:** A coluna status\_verificacao é essencial. No protótipo, apenas usuários com status "Verificado" (definido por um Admin) poderão aceder à funcionalidade de solicitar materiais, garantindo que as doações cheguem a quem realmente precisa, conforme a nossa pesquisa.

#### **2\. O Catálogo Híbrido: anuncios \- Onde Tudo Acontece**

Esta é a inovação central do nosso modelo, substituindo o antigo sistema de estoques. A tabela anuncios é o nosso catálogo unificado.

* **Conexões Principais:** anuncios conecta-se a usuarios (o Doador original), categorias\_material, anuncio\_fotos, e **opcionalmente** a bancos\_de\_materiais.  
* **O que significa (O Modelo Híbrido):**  
  * **Se banco\_de\_materiais\_id é NULL:** É uma doação direta (P2P). O material está no endereco\_retirada\_customizado (ex: a obra do "Júlio").  
  * **Se banco\_de\_materiais\_id está PREENCHIDO:** O material está fisicamente num dos nossos bancos\_de\_materiais (ex: doado pelo "Sérgio"). O app mostrará o endereço do Banco como local de retirada.  
* **Utilidade no App (Protótipo):**  
  * **Tela "Anunciar Material" (Doador):** O formulário preenche esta tabela, incluindo fotos (anuncio\_fotos), quantidade, condição e, crucialmente, a escolha do **Local de Retirada** (Minha Obra vs. Banco X).  
  * **Tela "Catálogo" (Beneficiário):** Esta tela **lê** a tabela anuncios. Os filtros (categoria, localização) funcionam consultando as colunas categoria\_material\_id, banco\_de\_materiais\_id e latitude/longitude. O app exibirá claramente se o item está numa obra específica ou num Banco de Materiais.  
  * **Redes de Segurança (Circular UX):** O status 'Rascunho' permite implementar a funcionalidade "Salvar Anúncio para Depois".

#### **3\. O Fluxo de Transação: solicitacoes e agendamentos\_logistica**

Estas tabelas gerem o "match" entre oferta e demanda e a entrega física, de forma modular.

* **Conexão 1: solicitacoes (O Match)**  
  * **Liga:** beneficiario\_id \+ anuncio\_id.  
  * **O que significa:** Regista que a "Ana" (Beneficiária) demonstrou interesse no item X anunciado pelo "Júlio" (Doador) ou disponível no Banco Y.  
  * **Utilidade no App (Protótipo):**  
    * **Tela "Detalhes do Anúncio":** O botão "Solicitar" cria uma linha nesta tabela com status 'Pendente'.  
    * **Tela "Minhas Solicitações" (Beneficiário):** Mostra o histórico de pedidos lendo esta tabela.  
    * **Tela "Meus Anúncios" (Doador/Admin do Banco):** Mostra as solicitações pendentes para os seus anúncios. O botão "Aprovar" simplesmente atualiza o status nesta tabela para 'Aprovada\_Doador'.  
* **Conexão 2: agendamentos\_logistica (A Entrega Modular)**  
  * **Liga:** solicitacao\_id \+ transportador\_id (opcional).  
  * **O que significa:** Representa o agendamento da entrega *depois* que uma solicitação foi aprovada. Separa a lógica da entrega do "match".  
  * **Utilidade no App (Protótipo):**  
    * **Fluxo Modular (Circular UX):** Permite que a tela/módulo de agendamento seja separada. Se a data precisar ser alterada, só esta tabela é modificada.  
    * **Tela "Agendamento":** Exibe a data\_agendada e o status\_logistica ('Agendada', 'Coletada', 'Entregue').  
    * **Confirmações:** As colunas confirmacao\_retirada e confirmacao\_entrega permitem implementar botões no app para o Doador/Banco e o Beneficiário confirmarem as etapas, aumentando a segurança e o controlo.

#### **4\. Preparação para o Futuro: Gamificação e Impacto**

Estas tabelas já estão no schema para suportar funcionalidades futuras importantes para o engajamento, especialmente do Doador Corporativo.

* **Tabelas:** gamificacao\_selos, usuario\_selos.  
* **O que significa:** Permitem atribuir "selos" (conquistas) aos usuários com base nas suas ações (ex: número de doações concluídas).  
* **Utilidade no App (Roadmap):**  
  * **Dashboard de Impacto:** Embora não tenha uma tabela própria, o dashboard será construído consultando principalmente a tabela anuncios (ex: SUM(peso\_estimado\_kg) WHERE doador\_id \= X AND status \= 'Doado') e solicitacoes (ex: COUNT(\*) WHERE beneficiario\_id \= Y AND status \= 'Finalizada').  
  * **Perfil do Usuário:** A secção de "Meus Selos" ou "Minhas Conquistas" lerá a tabela usuario\_selos.

### **Conclusão**

Este novo "cérebro" (schema v3.0) é muito mais poderoso. Ele suporta a flexibilidade do modelo híbrido, implementa as funcionalidades essenciais do seu protótipo (catálogo visual, solicitação, aprovação, logística modular) e já prepara o terreno para as funcionalidades de engajamento e métricas de impacto que são cruciais para os seus stakeholders corporativos e institucionais. Cada tela do seu protótipo agora tem uma correspondência direta e lógica nas tabelas e conexões do banco de dados.

