
CREATE SCHEMA IF NOT EXISTS `constman` DEFAULT CHARACTER SET utf8;
USE `constman`;

-- CREATE TABLE IF NOT EXISTS `constman`.`Usuarios` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `nome` VARCHAR(255) NOT NULL,
--   `usuario` VARCHAR(255) NOT NULL,
--   `senha` VARCHAR(255) NOT NULL,
--   `ativo` TINYINT NULL DEFAULT 1,
--   `dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP,
--   `dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   PRIMARY KEY (`id`))
-- ENGINE = InnoDB;


-- CREATE TABLE IF NOT EXISTS `constman`.`TiposDespesas` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `descricao` LONGTEXT NOT NULL,
--   `dtCriacao` datetime DEFAULT CURRENT_TIMESTAMP,
--   `dtAtualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   PRIMARY KEY (`id`))
-- ENGINE = InnoDB;

-- CREATE TABLE IF NOT EXISTS `dart`.`tipos_despesas` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `descricao` LONGTEXT NOT NULL,
--   `dt_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
--   `dt_autalizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   `id_usuario` INT NULL,
--   PRIMARY KEY (`id`),
--   CONSTRAINT `id_usuario`
--     FOREIGN KEY (`id_usuario`)
--     REFERENCES `dart`.`usuarios` (`id`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)
-- ENGINE = InnoDB;