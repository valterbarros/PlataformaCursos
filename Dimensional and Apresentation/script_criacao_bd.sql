DROP DATABASE mydb;


CREATE DATABASE mydb;
USe mydb;

CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(145) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `carteira` DECIMAL NOT NULL DEFAULT 0,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `data_nascimento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`administrador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `preco` DOUBLE NOT NULL,
  `desenvolvedor_id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_curso_desenvolvedor_idx` (`desenvolvedor_id` ASC),
  INDEX `fk_curso_categoria1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_curso_desenvolvedor`
    FOREIGN KEY (`desenvolvedor_id`)
    REFERENCES `mydb`.`administrador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `mydb`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`conteudo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.CONTEUDO (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_id` INT NOT NULL,
  `conteudo` VARCHAR(45) NOT NULL,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conteudo_tipo1_idx` (`tipo_id` ASC),
  INDEX `fk_conteudo_curso1_idx` (`curso_id` ASC),
  CONSTRAINT `fk_conteudo_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `mydb`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conteudo_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `mydb`.`curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`matricula` (
  `aluno_id` INT NOT NULL,
  `curso_id` INT NOT NULL,
  `data_matricula` DATE NOT NULL,
  `data_termino` DATE NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  `data_limite` DATE NOT NULL,
  PRIMARY KEY (`id`, `aluno_id`, `curso_id`),
  INDEX `fk_aluno_has_curso_curso1_idx` (`curso_id` ASC),
  INDEX `fk_aluno_has_curso_aluno1_idx` (`aluno_id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `mydb`.`retorno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`retorno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `texto` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  `qualificacao` TINYINT(1) NULL,
  `aluno_id` INT NOT NULL,
  `conteudo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_retorno_aluno1_idx` (`aluno_id` ASC),
  INDEX `fk_retorno_conteudo1_idx` (`conteudo_id` ASC),
  CONSTRAINT `fk_retorno_aluno1`
    FOREIGN KEY (`aluno_id`)
    REFERENCES `mydb`.`aluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retorno_conteudo1`
    FOREIGN KEY (`conteudo_id`)
    REFERENCES `mydb`.CONTEUDO (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
