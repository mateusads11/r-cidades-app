### **Proposta A: App R+Cidades** 

### Este documento consolida a estratégia, estrutura e plano de ação para a Proposta A do aplicativo R+Cidades, com base nos artefatos de UX (Personas, Jornadas), no modelo de banco de dados (schema v3.0 Híbrido) e no protótipo navegável.

#### **1\. Ideação e Estrutura do Aplicativo (Revisado)**

Nossa proposta implementa um **modelo híbrido** que combina a agilidade de um marketplace P2P com a robustez de um Banco de Materiais centralizado. A base técnica é o `schema.sql` v3.0, que suporta este ecossistema.

##### **1.1. Lista de Funcionalidades Essenciais (MVP)**

As funcionalidades abaixo são extraídas diretamente do nosso banco de dados final (`schema.sql` v3.0) e do protótipo.

* **Módulo de Usuários (Tabela `usuarios`)**  
  * **Cadastro e Login:** Sistema de autenticação seguro.  
  * **Diferenciação de Perfil:** O `tipo_usuario` ('Doador\_PF', 'Doador\_PJ', 'Beneficiario') personaliza a experiência no app desde o cadastro.  
  * **Validação de Beneficiários:** A coluna `status_verificacao` implementa a regra de negócio de que beneficiários precisam ser aprovados por um parceiro (Admin) para poderem solicitar materiais.  
* **Módulo de Anúncios (Tabela `anuncios`, `anuncio_fotos`)**  
  * **Catálogo Unificado:** Esta tabela é o coração do app, funcionando como o catálogo visual de **todos** os materiais disponíveis, sejam eles de doação direta ou do Banco de Materiais.  
  * **Cadastro de Anúncio (Doador):** Formulário para o doador cadastrar um item, incluindo:  
    * Título, categoria, descrição, quantidade, condição e fotos.  
    * **Localização Híbrida:** O doador escolhe se o material está em um `endereco_retirada_customizado` (P2P) ou se será doado para um `banco_de_materiais_id`.  
  * **Rede de Segurança (Circular UX):** O `status` 'Rascunho' permite ao doador salvar um anúncio para publicar depois.  
* **Módulo de Solicitações (Tabela `solicitacoes`)**  
  * **Busca e Filtros Avançados (Beneficiário):** Ferramenta de busca por nome e filtros por categoria, condição e localização (obras P2P vs. Bancos de Materiais).  
  * **Sistema de "Match" e Solicitação:** Beneficiários podem enviar uma "solicitação de doação" para um anúncio específico. O Doador recebe a notificação e pode aprovar ou rejeitar, garantindo controlo.  
  * **Justificativa de Uso:** Um campo de texto obrigatório (`justificativa_beneficiario`) para o beneficiário explicar o seu projeto.  
* **Módulo de Logística (Tabela `agendamentos_logistica`)**  
  * **Agendamento Modular (Circular UX):** Após a aprovação da solicitação, um módulo separado é ativado para agendar a logística, conectando Doador, Beneficiário e Transportador.  
  * **Confirmação em Etapas:** O sistema permite a confirmação da retirada e da entrega, garantindo a segurança do processo.

##### **1.2. Organização das Seções do App** 

##### As funcionalidades são organizadas numa navegação por abas (rodapé), padrão em aplicativos modernos, garantindo consistência e intuitividade.

1. **Home:** Tela inicial contextual (diferente para Doador e Beneficiário).  
2. **Catálogo:** A vitrine principal para o Beneficiário explorar todos os `anuncios` disponíveis.  
3. **Doar (+):** Botão de ação central que leva o Doador diretamente para o formulário de `Cadastro de Anúncio`.  
4. **Minhas Atividades:** Área logada onde Doador e Beneficiário acompanham o `status` de seus anúncios, doações e solicitações.  
5. **Perfil:** Gestão da conta do usuário, acesso a configurações e à tela "Sobre".

##### **1.3. Fluxograma de Navegação** 

##### O fluxo agora abrange ambos os perfis principais e reflete a estrutura do protótipo.

1. **Abre o App** → Tela de Login/Cadastro.  
2. **Faz o Login (como Beneficiário)** → Tela Home Beneficiário.  
   * *Navegação:* Usa a busca ou clica em "Catálogo" → Tela Catálogo.  
   * *No Catálogo:* Clica num item → Tela Detalhes do Anúncio.  
   * *Nos Detalhes:* Clica em "Solicitar" → Tela Formulário de Solicitação.  
   * *No Formulário:* Preenche e envia → Tela "Minhas Solicitações" (com o novo pedido em status "Pendente").  
3. **Faz o Login (como Doador)** → Tela Home Doador.  
   * *Navegação:* Clica no botão `+` (Doar) → Tela Cadastro de Anúncio.  
   * *No Cadastro:* Preenche e publica → Volta para a Home Doador.  
   * *Na Home:* Clica em um anúncio com notificação → Tela Gestão de Anúncios (Aprovação).  
   * *Na Aprovação:* Clica em "Aprovar" → Tela de Agendamento Logístico (para coordenar a entrega).  
   * Clica em "Perfil" → Clica em "Ver Dashboard" → **Tela Dashboard de Impacto.**

#### **2\. Guia de Telas para o Squad de UI**

Este é o briefing detalhado para o Squad de UI. A vossa missão é aplicar a identidade visual (cores, fontes) sobre a estrutura de wireframes já definida no protótipo, além de criar as telas de apoio para garantir uma experiência completa.

##### **2.1. As 12 Telas Essenciais (Já no Protótipo)**

##### O protótipo no Figma já contém o esqueleto para estas telas. O vosso trabalho é criar o design de alta fidelidade para cada uma, seguindo os princípios de UI da nossa pesquisa.

1. **Tela de Login / Cadastro**  
2. **Tela de Escolha de Perfil**  
3. **Tela Home (Beneficiário)**  
4. **Tela Home (Doador)**  
5. **Tela de Catálogo de Materiais**  
6. **Tela de Detalhes do Anúncio**  
7. **Tela de Formulário de Solicitação**  
8. **Tela de Minhas Solicitações (Beneficiário)**  
9. **Tela de Cadastro de Anúncio (Doador)**  
10. **Tela de Gestão de Anúncios (Aprovação)**  
11. **Tela de Agendamento Logístico**  
12. **Tela de Dashboard de Impacto (Doador PJ)**

##### **2.2. Telas de Apoio a Serem Desenhadas**

Estas são as telas que complementam o fluxo e garantem uma experiência robusta. O Squad de UX (eu) fornecerá o wireframe básico se necessário, mas o Squad de UI deve focar em aplicar a identidade visual.

* **Telas de "Estado Vazio" (Empty States):**  
  * Tela "Minhas Solicitações" quando o usuário ainda não fez nenhum pedido.  
  * Tela "Catálogo" quando uma busca não retorna resultados.  
  * Tela "Home Doador" quando o doador ainda não tem nenhum anúncio.  
  * *Ação:* Criar ilustrações ou mensagens amigáveis para guiar o usuário (ex: "Nenhum material encontrado. Tente uma busca diferente\!" ou "Você ainda não tem anúncios. Que tal começar a doar?").  
* **Telas de Feedback e Confirmação:**  
  * **Sucesso:** Uma tela modal (pop-up) ou tela cheia para confirmar ações importantes (ex: "Solicitação enviada com sucesso\!", "Anúncio publicado\!").  
  * **Erro:** Como o app comunica um erro? (Ex: falha no upload de imagem, falha de conexão).  
  * **Carregamento (Loading):** Como é a animação ou o indicador de carregamento enquanto os dados são buscados?  
* **Telas de Perfil e Configurações:**  
  * **Tela de Perfil Principal:** Uma tela central que o usuário acede pelo rodapé. Deve conter atalhos para "Meus Dados", "Minhas Atividades" (Doações/Solicitações), "Notificações", "Sobre o R+Cidades" e "Sair".  
  * **Tela Editar Perfil:** Formulário para o usuário editar nome, senha, endereço, etc.  
* **Tela de Notificações:** Uma lista centralizada de todas as notificações recebidas pelo usuário (ex: "Sua solicitação foi aprovada\!", "Você recebeu um novo pedido para o seu anúncio de Tijolos").

#### **3\. Plano de Ação**

#### **Squad de UI:**

* **Ação Imediata:** Analisar o protótipo no Figma e este documento.  
  * **Próximo Passo:** Começar a desenvolver o **Style Guide** (cores, tipografia, botões, ícones) no Figma.  
  * **A fazer:** Começar a aplicar o design de alta fidelidade nas telas principais, começando pela **Home (Beneficiário)** e pelo **Catálogo**.

