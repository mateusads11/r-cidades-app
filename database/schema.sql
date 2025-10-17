-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema R_Cidades_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema R_Cidades_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `R_Cidades_DB` DEFAULT CHARACTER SET utf8mb4 ;
USE `R_Cidades_DB` ;

-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`pontos_de_coleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`pontos_de_coleta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `capacidade_maxima` DECIMAL(10,2) NULL DEFAULT NULL,
  `estoques_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pontos_de_coleta_estoques1_idx` (`estoques_id` ASC) VISIBLE,
  CONSTRAINT `fk_pontos_de_coleta_estoques1`
    FOREIGN KEY (`estoques_id`)
    REFERENCES `R_Cidades_DB`.`estoques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`estoques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`estoques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `material_id` INT NOT NULL,
  `ponto_de_coleta_id` INT NOT NULL,
  `quantidade_disponivel` DECIMAL(10,2) NOT NULL,
  `estado_conservacao` ENUM('Novo', 'Usado - Bom', 'Requer Reparo') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_Material` (`material_id` ASC, `ponto_de_coleta_id` ASC, `estado_conservacao` ASC) VISIBLE,
  INDEX `ID_PontoColeta` (`ponto_de_coleta_id` ASC) VISIBLE,
  CONSTRAINT `ESTOQUE_ibfk_1`
    FOREIGN KEY (`material_id`)
    REFERENCES `R_Cidades_DB`.`materiais` (`id`),
  CONSTRAINT `ESTOQUE_ibfk_2`
    FOREIGN KEY (`ponto_de_coleta_id`)
    REFERENCES `R_Cidades_DB`.`pontos_de_coleta` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`materiais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`materiais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `unidade_medida` VARCHAR(20) NOT NULL,
  `categoria_material_id` INT NOT NULL,
  `estoques_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ID_Categoria` (`categoria_material_id` ASC) VISIBLE,
  INDEX `fk_materiais_estoques1_idx` (`estoques_id` ASC) VISIBLE,
  CONSTRAINT `MATERIAIS_ibfk_1`
    FOREIGN KEY (`categoria_material_id`)
    REFERENCES `R_Cidades_DB`.`categorias_material` (`id`),
  CONSTRAINT `fk_materiais_estoques1`
    FOREIGN KEY (`estoques_id`)
    REFERENCES `R_Cidades_DB`.`estoques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`categorias_material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`categorias_material` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `materiais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Nome` (`nome` ASC) VISIBLE,
  INDEX `fk_categorias_material_materiais1_idx` (`materiais_id` ASC) VISIBLE,
  CONSTRAINT `fk_categorias_material_materiais1`
    FOREIGN KEY (`materiais_id`)
    REFERENCES `R_Cidades_DB`.`materiais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `documento` VARCHAR(18) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(255) NULL DEFAULT NULL,
  `tipo_usuario` ENUM('Doador', 'Beneficiário', 'Admin', 'Voluntário') NOT NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Documento` (`documento` ASC) VISIBLE,
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`doacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`doacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `material_id` INT NOT NULL,
  `ponto_de_coleta_id` INT NOT NULL,
  `quantidade_doada` DECIMAL(10,2) NOT NULL,
  `data_agendamento` DATETIME NULL DEFAULT NULL,
  `data_recebimento` DATETIME NULL DEFAULT NULL,
  `status` ENUM('Agendada', 'Recebida', 'Cancelada') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ID_Doador` (`usuario_id` ASC) VISIBLE,
  INDEX `ID_Material` (`material_id` ASC) VISIBLE,
  INDEX `ID_PontoColeta` (`ponto_de_coleta_id` ASC) VISIBLE,
  CONSTRAINT `DOACOES_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`),
  CONSTRAINT `DOACOES_ibfk_2`
    FOREIGN KEY (`material_id`)
    REFERENCES `R_Cidades_DB`.`materiais` (`id`),
  CONSTRAINT `DOACOES_ibfk_3`
    FOREIGN KEY (`ponto_de_coleta_id`)
    REFERENCES `R_Cidades_DB`.`pontos_de_coleta` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`solicitacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`solicitacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `beneficiario_id` INT NOT NULL,
  `admin_id` INT NULL DEFAULT NULL,
  `data_solicitacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_aprovacao` DATETIME NULL DEFAULT NULL,
  `status` ENUM('Pendente', 'Aprovada', 'Rejeitada', 'Retirada') NOT NULL,
  `justificativa` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `ID_Beneficiario` (`beneficiario_id` ASC) VISIBLE,
  INDEX `ID_Admin` (`admin_id` ASC) VISIBLE,
  CONSTRAINT `SOLICITACOES_ibfk_1`
    FOREIGN KEY (`beneficiario_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`),
  CONSTRAINT `SOLICITACOES_ibfk_2`
    FOREIGN KEY (`admin_id`)
    REFERENCES `R_Cidades_DB`.`usuarios` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `R_Cidades_DB`.`itens_solicitacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `R_Cidades_DB`.`itens_solicitacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `solicitacao_id` INT NOT NULL,
  `material_id` INT NOT NULL,
  `quantidade_solicitada` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ID_Solicitacao` (`solicitacao_id` ASC) VISIBLE,
  INDEX `ID_Material` (`material_id` ASC) VISIBLE,
  CONSTRAINT `ITENS_SOLICITACAO_ibfk_1`
    FOREIGN KEY (`solicitacao_id`)
    REFERENCES `R_Cidades_DB`.`solicitacoes` (`id`),
  CONSTRAINT `ITENS_SOLICITACAO_ibfk_2`
    FOREIGN KEY (`material_id`)
    REFERENCES `R_Cidades_DB`.`materiais` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
