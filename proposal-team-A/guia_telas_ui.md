# Guia de Telas para Design de UI (R+Cidades - Proposta A)

Este documento detalha as telas essenciais identificadas no protótipo navegável e na estrutura do banco de dados (v3.0 Híbrido). O objetivo é guiar o time de UI na criação das interfaces no Figma, garantindo consistência com a lógica de UX e as necessidades do sistema.

**Princípios Gerais de UI (Conforme Pesquisa):**
* **Confiança:** Usar a paleta "Construção Consciente" (ou similar), tipografia clara (`Roboto`, `Montserrat`), incluir selos de verificação e logos de parceiros.
* **Simplicidade:** Focar na ação principal de cada tela, usar linguagem direta, ícones claros.
* **Acessibilidade:** Garantir bom contraste, fontes legíveis e áreas de toque adequadas.

---

**Lista de Telas Essenciais:**

**1. Tela: Login / Escolha de Perfil**
* **Propósito:** Autenticar o usuário e direcionar para a interface correta.
* **Elementos:** Campos para email/documento e senha; Botão "Entrar"; Link "Esqueci minha senha"; Opção clara para "Cadastrar-se"; (Opcional) Botões de login social (Google, etc.). No cadastro, perguntar claramente o `tipo_usuario` (Doador PF, PJ, Beneficiário - Transportador pode ser um fluxo separado).

**2. Tela: Home (Logado como Doador)**
* **Propósito:** Ponto central para o Doador gerenciar suas atividades.
* **Elementos:** Saudação ("Olá, [Nome]!"); Botão de destaque (+) para "Anunciar Novo Material"; Visão geral rápida dos anúncios ativos (com foto, título, status); Atalho para "Meus Anúncios"; Atalho para "Dashboard de Impacto" (se for Doador PJ).

**3. Tela: Home (Logado como Beneficiário)**
* **Propósito:** Descoberta e acesso rápido aos materiais disponíveis.
* **Elementos:** Barra de busca proeminente no topo; Ícones/Cards para as `categorias_material` principais; Grade/Lista com os "Últimos Anúncios Adicionados" (mostrar foto, título, localização - Ex: "Obra - Jurerê" ou "Banco Itacorubi"); Atalho para "Ver Catálogo Completo"; Atalho para "Minhas Solicitações".

**4. Tela: Cadastro de Anúncio (Fluxo do Doador)**
* **Propósito:** Permitir ao doador descrever detalhadamente o material que deseja doar.
* **Elementos:** Campos claros para:
    * `titulo` (Nome do Anúncio)
    * `categoria_material_id` (Dropdown/Seleção)
    * `descricao` (Campo de texto)
    * `quantidade` e `unidade_medida` (Campos numérico e de texto/seleção)
    * `condicao` (Seleção: Novo, Usado-Bom, etc.)
    * **Localização:** Opção clara: [ ] Meu Endereço/Obra (campo para `endereco_retirada_customizado`) OU [ ] Doar para Banco de Materiais (Dropdown para selecionar o `banco_de_materiais_id`).
    * Upload de Fotos (`anuncio_fotos`) - permitir múltiplas imagens.
    * Botões: "Salvar Rascunho", "Publicar Anúncio".

**5. Tela: Catálogo (Fluxo do Beneficiário)**
* **Propósito:** Permitir ao beneficiário encontrar os materiais que necessita.
* **Elementos:** Barra de busca no topo; Botões/Opções de Filtro (por `categoria_material_id`, `condicao`, Localização/Distância - incluindo a opção "Apenas Bancos de Materiais"); Grade ou Lista de `anuncios` disponíveis (cada item mostra foto principal, `titulo`, `quantidade`, `condicao` e Localização).

**6. Tela: Detalhes do Anúncio**
* **Propósito:** Mostrar todas as informações de um item específico antes da solicitação.
* **Elementos:** Carrossel/Galeria de `anuncio_fotos`; `titulo` grande; `descricao` completa; `quantidade` e `unidade_medida`; `condicao`; **Localização clara** (mapa se for P2P, ou endereço do Banco); Informações do Doador (se P2P e permitido); Botão de ação principal: "Solicitar este Item".

**7. Tela: Formulário de Solicitação (Fluxo do Beneficiário)**
* **Propósito:** Coletar a justificativa do beneficiário e confirmar o pedido.
* **Elementos:** Resumo do item solicitado (foto, título); Campo de texto **obrigatório** para `justificativa_beneficiario`; Confirmação dos dados de contato/entrega do beneficiário; Botão "Enviar Solicitação".

**8. Tela: Gestão de Anúncios / Solicitações Recebidas (Fluxo do Doador / Admin Banco)**
* **Propósito:** Permitir ao doador/admin aprovar ou rejeitar os pedidos feitos para seus anúncios.
* **Elementos:** Lista de solicitações recebidas (`status = 'Pendente'`). Cada item deve mostrar: Foto/Nome do material; Nome do solicitante (`beneficiario_id`); `justificativa_beneficiario`; Botões: "Aprovar Solicitação", "Rejeitar Solicitação". (Opcional: link para ver perfil do beneficiário).

**9. Tela: Minhas Solicitações (Fluxo do Beneficiário)**
* **Propósito:** Permitir ao beneficiário acompanhar o andamento de seus pedidos.
* **Elementos:** Lista de `solicitacoes` feitas pelo usuário. Cada item mostra: Foto/Nome do material; Data da solicitação; **Status Atualizado** (`Pendente`, `Aprovado_Doador`, `Agendada`, `Entregue`, `Rejeitada_Doador` - usar cores ou ícones para diferenciar); Link para ver detalhes do agendamento (se aplicável).

**10. Tela: Agendamento Logístico (Detalhes)**
* **Propósito:** Mostrar os detalhes da coleta/entrega após aprovação.
* **Elementos:** Resumo do item/solicitação; **Data e Hora Agendada** (`data_agendada`); Endereço de Coleta (do anúncio); Endereço de Entrega (do beneficiário); Informações do Transportador (se houver `transportador_id`); **Status da Logística** (`Agendada`, `Coletada`, `Entregue`); Botões (se aplicável) para "Confirmar Coleta" (Doador/Banco) e "Confirmar Entrega" (Beneficiário).

**11. Tela: Dashboard de Impacto (Apenas Doador PJ)**
* **Propósito:** Apresentar as métricas de ESG para o doador corporativo.
* **Elementos:** Gráficos simples e claros mostrando: Total de doações concluídas; Peso total estimado desviado do aterro (soma de `peso_estimado_kg`); Número estimado de famílias impactadas (baseado nas solicitações); Selos conquistados (`usuario_selos`); Botão para gerar/baixar o "Certificado de Impacto".

---
**Observação:** Estas são as telas *essenciais*. Outras telas (como "Esqueci minha senha", "Editar Perfil", "Notificações", etc.) também serão necessárias, mas estas 11 formam o núcleo da experiência do MVP.
