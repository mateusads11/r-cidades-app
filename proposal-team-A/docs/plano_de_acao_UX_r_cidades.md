### **Plano de Ação: Fundações de Produto e UX (R+Cidades)**

**blueprint** (a planta de engenharia) do aplicativo. 

#### **Fase 1: Definição do Usuário (Quem estamos ajudando?)**

Este é o coração do UX. Antes de desenhar qualquer tela, precisamos saber *para quem* estamos desenhando.

* **Ação 1: Criar as Personas (Foco: Doadores)**
    * **O que é:** Um documento de 1 página descrevendo nosso usuário-alvo. Não é uma pessoa real, mas um arquétipo.
    * **Ferramenta Leve:** Um arquivo de texto (`.md` no seu projeto), Google Docs, ou até o corpo de uma Issue no GitHub.
    * **Exemplo de Persona (Rascunho):**
        * **Nome:** Carlos, 45 anos.
        * **Profissão:** Mestre de Obras.
        * **História:** "Carlos sempre termina uma pequena reforma com sobras. Sobra 1 saco de cimento, meia caixa de azulejo, 10 telhas. Ele não quer jogar fora, pois sabe que 'é dinheiro', mas o material fica ocupando espaço e estragando no quintal."
        * **Necessidade:** Uma forma **rápida e fácil** de se livrar das sobras, sentindo que está ajudando alguém e não "jogando dinheiro fora".
        * **Frustração:** "Ligar para ONGs é demorado, ninguém vem buscar pouca coisa."

* **Ação 2: Definir a Jornada do Usuário (O que ele faz?)**
    * **O que é:** Exatamente o que você disse. É um mapa dos passos, pensamentos e emoções do usuário **antes, durante e depois** de usar o app.
    * **Ferramenta Leve:** Uma tabela simples (Google Docs, ou uma tabela em Markdown).
    * **Exemplo de Jornada (Foco: Doador):**

| Etapa | Ação do Usuário | Pensamento/Sentimento | Oportunidade para o App |
| :--- | :--- | :--- | :--- |
| **Descoberta** | Termina a obra e vê as sobras. | "Que chato, o que faço com isso?" | Ser encontrado (divulgação). |
| **Consideração** | Procura "doar material de construção" no Google. | "Será que é complicado? Vão vir buscar?" | Ter um site/app fácil de achar. |
| **Cadastro** | Baixa o app e se cadastra. | "Espero que não peçam mil dados." | Pedir o mínimo de dados (usar seu DB como guia!). |
| **Agendamento** | Tira foto do material, escolhe o local. | "Foi mais fácil do que eu pensava." | Ter um formulário simples (baseado na tabela `doacoes`). |
| **Confirmação** | Recebe a confirmação da doação. | "Legal! Trabalho feito." | Enviar uma notificação clara e positiva. |

---

#### **Fase 2: Estrutura da Informação (Onde as coisas ficam?)**

Agora que sabemos *quem* é o usuário, vamos organizar o app para ele.

* **Ação 3: Criar o Fluxograma de Navegação (Como ele anda?)**
    * **O que é:** O que você mencionou. É um mapa visual de **telas** e **ações**.
    * **Ferramenta Leve:** **draw.io** (agora se chama diagrams.net). Funciona 100% no navegador, é gratuito e muito leve. É perfeito para isso.
    * **Como Fazer:** Crie caixas para as telas e setas para as ações.
        * *(Tela) Home* → (clica em "Doar") → *(Tela) Formulário de Doação*
        * *(Tela) Formulário de Doação* → (clica em "Enviar") → *(Tela) Confirmação*
        * *(Tela) Home* → (clica em "Perfil") → *(Tela) Minhas Doações*

---

#### **Fase 3: Esboço (O que tem em cada tela?)**

Este é o **Wireframe de Baixa Fidelidade** 

* **Ação 4: Desenhar os Wireframes (O "Esqueleto")**
    * **O que é:** Um desenho *sem cores, sem fontes bonitas, sem imagens*. Apenas caixas, linhas e texto-padrão ("Lorem Ipsum" ou "Título da Página").
    * **Ferramenta Leve:**
        1.  **Caneta e Papel (Recomendado):** Desenhe as telas em um caderno, tire uma foto nítida e suba a imagem para a Issue no GitHub. É a ferramenta mais rápida e leve do mundo.
        2.  **draw.io:** Você também pode usar o draw.io para criar caixas e simular os layouts das telas.

---

### **Próximo Passo**

1.  **Criar as seguintes Issues e colocá-las na coluna**"A Fazer"**:
    * `[UX] Definir Personas de Usuários (Doador e Beneficiário)`
    * `[UX] Mapear a Jornada do Usuário Doador`
    * `[UX] Desenhar o Fluxograma de Navegação do App (v1)`
    * `[UX] Criar Wireframes de Baixa Fidelidade (Fluxo de Doação)`

