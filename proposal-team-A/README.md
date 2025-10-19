# Proposta A: Ecossistema R+Cidades

Esta pasta contém os artefatos e o protótipo desenvolvidos pela Equipe A para o projeto R+Cidades. Nossa proposta foca em um **modelo híbrido** que combina a agilidade de um marketplace P2P com a robustez de um Banco de Materiais centralizado, garantindo flexibilidade para diferentes tipos de doadores e necessidades logísticas.

## 🧠 O Cérebro da Proposta: O Schema Híbrido (v3.0)

A base da nossa solução é um banco de dados relacional (MySQL) projetado para ser escalável e eficiente. A estrutura principal gira em torno da tabela `anuncios`, que funciona como um catálogo unificado:

* **Doação Direta (P2P):** Quando um doador (ex: grande construtora) cadastra um item diretamente de sua obra, o anúncio aponta para um endereço customizado.
* **Banco de Materiais:** Quando a doação é destinada a um ponto central (ex: Ecoponto parceiro), o anúncio aponta para o endereço desse banco.

Essa dualidade permite que beneficiários validados solicitem materiais tanto de grandes doações P2P quanto do estoque centralizado. A lógica completa, incluindo o fluxo de solicitação, aprovação e logística modular, está detalhada no schema e no guia principal do banco de dados na pasta `/docs`.

* **[Visualizar o Diagrama ER (v3.0 Híbrido)](../docs/diagrama_entidade_relacionamento_v3.png)**
* **[Consultar o Script SQL (v3.0 Híbrido)](../database/schema_3.sql)**
* **[Ler o Guia Detalhado ("O Cérebro do App")](../docs/O%20C%C3%A9rebro%20do%20Aplicativo.pdf)**

## 🚀 Protótipo Navegável

Para visualizar como essa estrutura se traduz em uma experiência de usuário funcional e intuitiva, criamos um protótipo navegável que demonstra os fluxos principais para Doadores e Beneficiários.

<<<<<<< HEAD
* **[Clique aqui para interagir com o Protótipo Navegável da Equipe A](https://mateusads11.github.io/r-cidades-app/proposal-team-A/index.html)** 
=======
* **[Clique aqui para interagir com o Protótipo Navegável da Equipe A](https://mateusads11.github.io/r-cidades-app/proposal-team-A/index.html)**
>>>>>>> 21bf3a439bc0a7dd8b4e23efffe82c9661658ec4

O protótipo foca nas funcionalidades essenciais do MVP (Produto Mínimo Viável) e aplica os princípios de design (Confiança, Simplicidade, UX Circular) definidos na pesquisa.

## 🎨 Telas Principais (Guia para UI)

O protótipo foi estruturado em torno das seguintes telas-chave, que servem como guia para o desenvolvimento da interface pelo time de UI:

1.  **Login / Escolha de Perfil:** Porta de entrada e diferenciação de fluxo.
2.  **Home (Doador):** Visão geral e acesso rápido para anunciar.
3.  **Home (Beneficiário):** Descoberta de materiais (busca, categorias).
4.  **Cadastro de Anúncio:** Formulário para o doador detalhar o material e o local.
5.  **Catálogo:** Vitrine de materiais disponíveis com filtros avançados.
6.  **Detalhes do Anúncio:** Informações completas e botão para solicitar.
7.  **Solicitação:** Justificativa e envio do pedido pelo beneficiário.
8.  **Gestão de Anúncios (Doador):** Aprovação/rejeição de solicitações.
9.  **Minhas Solicitações (Beneficiário):** Acompanhamento de status.
10. **Agendamento Logístico:** Coordenação da entrega/retirada.
11. **Dashboard de Impacto (Doador PJ):** Visualização de métricas ESG.

Um guia mais detalhado para o time de UI, com os elementos específicos de cada tela, está sendo preparado.
