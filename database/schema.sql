-- -----------------------------------------------------
-- Passo 1: Criação do Banco de Dados
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS R_Cidades_DB
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

-- -----------------------------------------------------
-- Passo 2: Selecionar o Banco de Dados para uso
-- -----------------------------------------------------
USE R_Cidades_DB;

-- -----------------------------------------------------
-- Passo 3: Criação das Tabelas
-- -----------------------------------------------------

-- Tabela para gerenciar todos os usuários do sistema (Doadores, Beneficiários, etc.)
CREATE TABLE IF NOT EXISTS USUARIOS (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Documento VARCHAR(18) NOT NULL UNIQUE,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(255),
    TipoUsuario ENUM('Doador', 'Beneficiário', 'Admin', 'Voluntário') NOT NULL,
    DataCadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para classificar os tipos de materiais
CREATE TABLE IF NOT EXISTS CATEGORIAS_MATERIAL (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    NomeCategoria VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela para gerenciar os locais físicos de armazenamento
CREATE TABLE IF NOT EXISTS PONTOS_DE_COLETA (
    ID_PontoColeta INT AUTO_INCREMENT PRIMARY KEY,
    NomePonto VARCHAR(100) NOT NULL,
    EnderecoPonto VARCHAR(255) NOT NULL,
    CapacidadeMax DECIMAL(10, 2)
);

-- Tabela com o catálogo mestre de todos os materiais
CREATE TABLE IF NOT EXISTS MATERIAIS (
    ID_Material INT AUTO_INCREMENT PRIMARY KEY,
    NomeMaterial VARCHAR(150) NOT NULL,
    Descricao TEXT,
    UnidadeMedida VARCHAR(20) NOT NULL,
    ID_Categoria INT NOT NULL,
    FOREIGN KEY (ID_Categoria) REFERENCES CATEGORIAS_MATERIAL(ID_Categoria)
);

-- Tabela para controlar o inventário real em cada ponto de coleta
CREATE TABLE IF NOT EXISTS ESTOQUE (
    ID_Estoque INT AUTO_INCREMENT PRIMARY KEY,
    ID_Material INT NOT NULL,
    ID_PontoColeta INT NOT NULL,
    QuantidadeDisponivel DECIMAL(10, 2) NOT NULL,
    EstadoConservacao ENUM('Novo', 'Usado - Bom', 'Requer Reparo') NOT NULL,
    FOREIGN KEY (ID_Material) REFERENCES MATERIAIS(ID_Material),
    FOREIGN KEY (ID_PontoColeta) REFERENCES PONTOS_DE_COLETA(ID_PontoColeta),
    UNIQUE (ID_Material, ID_PontoColeta, EstadoConservacao) -- Garante que não haja entradas duplicadas para o mesmo item
);

-- Tabela para registrar todas as doações recebidas
CREATE TABLE IF NOT EXISTS DOACOES (
    ID_Doacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Doador INT NOT NULL,
    ID_Material INT NOT NULL,
    ID_PontoColeta INT NOT NULL,
    QuantidadeDoada DECIMAL(10, 2) NOT NULL,
    DataAgendamento DATETIME,
    DataRecebimento DATETIME,
    StatusDoacao ENUM('Agendada', 'Recebida', 'Cancelada') NOT NULL,
    FOREIGN KEY (ID_Doador) REFERENCES USUARIOS(ID_Usuario),
    FOREIGN KEY (ID_Material) REFERENCES MATERIAIS(ID_Material),
    FOREIGN KEY (ID_PontoColeta) REFERENCES PONTOS_DE_COLETA(ID_PontoColeta)
);

-- Tabela para registrar os pedidos dos beneficiários
CREATE TABLE IF NOT EXISTS SOLICITACOES (
    ID_Solicitacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Beneficiario INT NOT NULL,
    ID_Admin INT, -- Pode ser nulo até a aprovação
    DataSolicitacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DataAprovacao DATETIME,
    StatusSolicitacao ENUM('Pendente', 'Aprovada', 'Rejeitada', 'Retirada') NOT NULL,
    Justificativa TEXT,
    FOREIGN KEY (ID_Beneficiario) REFERENCES USUARIOS(ID_Usuario),
    FOREIGN KEY (ID_Admin) REFERENCES USUARIOS(ID_Usuario)
);

-- Tabela associativa para detalhar os itens de cada solicitação
CREATE TABLE IF NOT EXISTS ITENS_SOLICITACAO (
    ID_ItemSolicitacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Solicitacao INT NOT NULL,
    ID_Material INT NOT NULL,
    QuantidadeSolicitada DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Solicitacao) REFERENCES SOLICITACOES(ID_Solicitacao),
    FOREIGN KEY (ID_Material) REFERENCES MATERIAIS(ID_Material)
);

-- Fim do Script