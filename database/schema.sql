-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema R_Cidades_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `R_Cidades_DB` DEFAULT CHARACTER SET utf8mb4 ;
USE `R_Cidades_DB` ;

-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `documento` VARCHAR(18) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(255) NULL DEFAULT NULL,
  `tipo_usuario` ENUM('Doador_PF', 'Doador_PJ', 'Beneficiario', 'Transportador', 'Admin') NOT NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_verificacao` ENUM('Nao Verificado', 'Pendente', 'Verificado', 'Rejeitado') NOT NULL DEFAULT 'Nao Verificado' COMMENT 'Controla a validação de Beneficiários e Transportadores',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `documento_UNIQUE` (`documento` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`categorias_material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`categorias_material` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`bancos_de_materiais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`bancos_de_materiais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL COMMENT 'Ex: \'Banco Itacorubi\', \'Galpão Central\'',
  `endereco` VARCHAR(255) NOT NULL,
  `latitude` DECIMAL(10,8) NULL,
  `longitude` DECIMAL(11,8) NULL,
  `responsavel_id` INT NULL COMMENT 'FK para o usuário admin responsável por este banco',
  PRIMARY KEY (`id`),
  INDEX `fk_bancos_de_materiais_usuarios1_idx` (`responsavel_id` ASC) VISIBLE,
  CONSTRAINT `fk_bancos_de_materiais_usuarios1`
    FOREIGN KEY (`responsavel_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela dos armazéns físicos (Ecopontos, galpões) do R+Cidades.';


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`anuncios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`anuncios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `doador_id` INT NOT NULL COMMENT 'O doador original (para gamificação e métricas)',
  `categoria_material_id` INT NOT NULL,
  `banco_de_materiais_id` INT NULL DEFAULT NULL COMMENT 'SE NULO = Doação Direta (P2P). SE PREENCHIDO = Material está no Banco.',
  `titulo` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `quantidade` DECIMAL(10,2) NOT NULL,
  `unidade_medida` VARCHAR(50) NULL COMMENT 'Ex: \'unidades\', \'m²\', \'kg\'',
  `condicao` ENUM('Novo', 'Usado - Bom', 'Requer Reparo') NOT NULL,
  `endereco_retirada_customizado` VARCHAR(255) NULL DEFAULT NULL COMMENT 'SE NULO, usar endereço do banco_de_materiais_id. SE PREENCHIDO, usar este.',
  `latitude` DECIMAL(10,8) NULL,
  `longitude` DECIMAL(11,8) NULL,
  `status` ENUM('Rascunho', 'Disponivel', 'Reservado', 'Doado', 'Expirado') NOT NULL DEFAULT 'Rascunho',
  `data_criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `peso_estimado_kg` DECIMAL(10,2) NULL COMMENT 'Para o dashboard de impacto',
  PRIMARY KEY (`id`),
  INDEX `fk_anuncios_usuarios1_idx` (`doador_id` ASC) VISIBLE,
  INDEX `fk_anuncios_categorias_material1_idx` (`categoria_material_id` ASC) VISIBLE,
  INDEX `fk_anuncios_bancos_de_materiais1_idx` (`banco_de_materiais_id` ASC) VISIBLE,
  CONSTRAINT `fk_anuncios_usuarios1`
    FOREIGN KEY (`doador_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_anuncios_categorias_material1`
    FOREIGN KEY (`categoria_material_id`)
    REFERENCES `R_Cidades_DB`.`categorias_material` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_anuncios_bancos_de_materiais1`
    FOREIGN KEY (`banco_de_materiais_id`)
    REFERENCES `R_Cidades_DB`.`bancos_de_materiais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Catálogo Unificado: Itens em doação direta (P2P) ou no Banco de Materiais.';


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`anuncio_fotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`anuncio_fotos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `anuncio_id` INT NOT NULL,
  `url_imagem` VARCHAR(255) NOT NULL,
  `ordem` INT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_anuncio_fotos_anuncios1_idx` (`anuncio_id` ASC) VISIBLE,
  CONSTRAINT `fk_anuncio_fotos_anuncios1`
    FOREIGN KEY (`anuncio_id`)
    REFERENCES `R_Cidades_DB`.`anuncios` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela para suportar múltiplas fotos por anúncio.';


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`solicitacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`solicitacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `beneficiario_id` INT NOT NULL,
  `anuncio_id` INT NOT NULL,
  `data_solicitacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('Pendente', 'Aprovada_Doador', 'Rejeitada_Doador', 'Agendada', 'Finalizada', 'Cancelada') NOT NULL DEFAULT 'Pendente',
  `justificativa_beneficiario` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_solicitacoes_usuarios1_idx` (`beneficiario_id` ASC) VISIBLE,
  INDEX `fk_solicitacoes_anuncios1_idx` (`anuncio_id` ASC) VISIBLE,
  CONSTRAINT `fk_solicitacoes_usuarios1`
    FOREIGN KEY (`beneficiario_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitacoes_anuncios1`
    FOREIGN KEY (`anuncio_id`)
    REFERENCES `R_Cidades_DB`.`anuncios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Registra o "match" entre um beneficiário e um anúncio do catálogo unificado.';


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`agendamentos_logistica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`agendamentos_logistica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `solicitacao_id` INT NOT NULL,
  `transportador_id` INT NULL COMMENT 'Pode ser nulo se o próprio beneficiário retirar',
  `data_agendada` DATETIME NOT NULL,
  `status_logistica` ENUM('Agendada', 'Coletada', 'Entregue', 'Cancelada') NOT NULL DEFAULT 'Agendada',
  `confirmacao_retirada` TINYINT(1) NULL DEFAULT 0 COMMENT 'Doador ou Banco confirma que foi coletado',
  `confirmacao_entrega` TINYINT(1) NULL DEFAULT 0 COMMENT 'Beneficiário confirma que recebeu',
  `observacoes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_agendamentos_logistica_solicitacoes1_idx` (`solicitacao_id` ASC) VISIBLE,
  INDEX `fk_agendamentos_logistica_usuarios1_idx` (`transportador_id` ASC) VISIBLE,
  CONSTRAINT `fk_agendamentos_logistica_solicitacoes1`
    FOREIGN KEY (`solicitacao_id`)
    REFERENCES `R_Cidades_DB`.`solicitacoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendamentos_logistica_usuarios1`
    FOREIGN KEY (`transportador_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Módulo de Logística Modularizado (Circular UX)';


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`gamificacao_selos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`gamificacao_selos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_selo` VARCHAR(100) NOT NULL COMMENT 'Ex: "Selo Construtor Social"',
  `descricao` TEXT NOT NULL,
  `url_icone` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabela de suporte para o Roadmap de Gamificação.';


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`usuario_selos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`usuario_selos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `selo_id` INT NOT NULL,
  `data_conquista` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_selos_usuarios1_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_usuario_selos_gamificacao_selos1_idx` (`selo_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_selos_usuarios1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_selos_gamificacao_selos1`
    FOREIGN KEY (`selo_id`)
    REFERENCES `R_Cidades_DB`.`gamificacao_selos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela de junção para a Gamificação.';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;