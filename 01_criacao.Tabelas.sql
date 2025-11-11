CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- ORDEM CORRIGIDA: DROP TABLE - Das mais dependentes (filhas) para as menos dependentes (pais)
-- -----------------------------------------------------

DROP TABLE IF EXISTS `Item_Doacao` ; 
DROP TABLE IF EXISTS `Doacao` ;
DROP TABLE IF EXISTS `Colheita` ;
DROP TABLE IF EXISTS `Cultivo` ;
DROP TABLE IF EXISTS `Voluntario` ;
DROP TABLE IF EXISTS `Instituicao` ;
DROP TABLE IF EXISTS `Canteiro` ;
DROP TABLE IF EXISTS `Planta` ;

-- -----------------------------------------------------
-- CRIAÇÃO DAS TABELAS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Voluntario` (CORRIGIDO: nome_voluntario)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Voluntario` (
  `idVoluntario` INT NOT NULL AUTO_INCREMENT,
  `nome_voluntario` VARCHAR(100) NOT NULL, 
  PRIMARY KEY (`idVoluntario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Instituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instituicao` (
  `idInstituicao` INT NOT NULL AUTO_INCREMENT,
  `nome_insti` VARCHAR(100) NOT NULL,
  `endereco_insti` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idInstituicao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Canteiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Canteiro` (
  `idCanteiro` INT NOT NULL AUTO_INCREMENT,
  `nome_canteiro` VARCHAR(45) NOT NULL,
  `tipo_solo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCanteiro`))
ENGINE = InnoDB;

-- Mantém índices UNIQUE (que não são criados automaticamente)
CREATE UNIQUE INDEX `nome_canteiro_UNIQUE` ON `Canteiro` (`nome_canteiro` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Planta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planta` (
  `idPlanta` INT NOT NULL AUTO_INCREMENT,
  `nome_planta` VARCHAR(45) NOT NULL,
  `dias_colheita` INT NOT NULL,
  PRIMARY KEY (`idPlanta`))
ENGINE = InnoDB;

-- Mantém índices UNIQUE
CREATE UNIQUE INDEX `nome_planta_UNIQUE` ON `Planta` (`nome_planta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Cultivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cultivo` (
  `idCultivo` INT NOT NULL AUTO_INCREMENT,
  `idVoluntario` INT NOT NULL,
  `idCanteiro` INT NOT NULL,
  `idPlanta` INT NOT NULL,
  `data_plantio` DATE NOT NULL,
  `quanti_plantada` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idCultivo`),
  CONSTRAINT `fk_Cultivo_Voluntario` 
    FOREIGN KEY (`idVoluntario`)
    REFERENCES `Voluntario` (`idVoluntario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cultivo_Canteiro` 
    FOREIGN KEY (`idCanteiro`)
    REFERENCES `Canteiro` (`idCanteiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cultivo_Planta` 
    FOREIGN KEY (`idPlanta`)
    REFERENCES `Planta` (`idPlanta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ÍNDICES FK SÃO CRIADOS AUTOMATICAMENTE PELO MYSQL


-- -----------------------------------------------------
-- Table `Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Colheita` (
  `idColheita` INT NOT NULL AUTO_INCREMENT,
  `idCultivo` INT NOT NULL,
  `idVoluntario` INT NOT NULL,
  `data_colheita` DATE NOT NULL,
  `quant_colheita` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idColheita`),
  CONSTRAINT `fk_Colheita_Cultivo`
    FOREIGN KEY (`idCultivo`)
    REFERENCES `Cultivo` (`idCultivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Voluntario`
    FOREIGN KEY (`idVoluntario`)
    REFERENCES `Voluntario` (`idVoluntario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Doacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Doacao` (
  `idDoacao` INT NOT NULL AUTO_INCREMENT,
  `data_doacao` DATE NOT NULL,
  `idInstituicao` INT NOT NULL,
  PRIMARY KEY (`idDoacao`),
  CONSTRAINT `fk_Doacao_Intituicao`
    FOREIGN KEY (`idInstituicao`)
    REFERENCES `Instituicao` (`idInstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Item_Doacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Item_Doacao` (
  `idDoacao` INT NOT NULL,
  `idColheita` INT NOT NULL,
  `quanti_doada` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idDoacao`, `idColheita`),
  CONSTRAINT `fk_ItemDoacao_Doacao`
    FOREIGN KEY (`idDoacao`)
    REFERENCES `Doacao` (`idDoacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItemDoacao_Colheita`
    FOREIGN KEY (`idColheita`)
    REFERENCES `Colheita` (`idColheita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;