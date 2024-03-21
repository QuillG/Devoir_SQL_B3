-- Active: 1698408179226@@127.0.0.1@3306@cinemasql
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cinemasql
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cinemasql` ;

-- -----------------------------------------------------
-- Schema cinemasql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinemasql` DEFAULT CHARACTER SET utf8 ;
USE `cinemasql` ;

DROP TABLE IF EXISTS `cinemasql`.`billet`;
DROP TABLE IF EXISTS `cinemasql`.`Seance_has_Tarif` ;
DROP TABLE IF EXISTS `cinemasql`.`seance` ;
DROP TABLE IF EXISTS `cinemasql`.`crenau` ;
DROP TABLE IF EXISTS `cinemasql`.`film_has_genre` ;
DROP TABLE IF EXISTS `cinemasql`.`film_has_acteur` ;
DROP TABLE IF EXISTS `cinemasql`.`film` ;
DROP TABLE IF EXISTS `cinemasql`.`acteur` ;
DROP TABLE IF EXISTS `cinemasql`.`realisateur` ;
DROP TABLE IF EXISTS `cinemasql`.`personne` ;
DROP TABLE IF EXISTS `cinemasql`.`tarif` ;
DROP TABLE IF EXISTS `cinemasql`.`limiteage` ;
DROP TABLE IF EXISTS `cinemasql`.`genre` ;
DROP TABLE IF EXISTS `cinemasql`.`langue` ;
DROP TABLE IF EXISTS `cinemasql`.`salle` ;

-- -----------------------------------------------------
-- Table `cinemasql`.`Salle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Salle` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Salle` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nb_Places` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Langue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Langue` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Langue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Langue` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`LimiteAge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`LimiteAge` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`LimiteAge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Intitule` VARCHAR(45) NOT NULL,
  `Age_Mini` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Film` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Film` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Titre` VARCHAR(100) NOT NULL,
  `Duree(Min)` INT NOT NULL,
  `Date_sortie` INT NOT NULL,
  `Synopsis` LONGTEXT NOT NULL,
  `Commentaire` MEDIUMTEXT NULL,
  `Avant-Premiere` TINYINT NOT NULL,
  `Duree_d'exploitation` INT NOT NULL DEFAULT 8,
  `Realisateur_id` INT NOT NULL,
  `LimiteAge_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Film_LimiteAge1_idx` (`LimiteAge_id` ASC) VISIBLE,
  CONSTRAINT `fk_Film_LimiteAge1`
    FOREIGN KEY (`LimiteAge_id`)
    REFERENCES `cinemasql`.`LimiteAge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Crenau`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Crenau` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Crenau` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Heure` TIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Seance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Seance` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Seance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Salle_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `Langue_id` INT NOT NULL,
  `Crenau_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Seance_Salle1_idx` (`Salle_id` ASC) VISIBLE,
  INDEX `fk_Plan_Seance_Film1_idx` (`Film_id` ASC) VISIBLE,
  INDEX `fk_Plan_Seance_Langue1_idx` (`Langue_id` ASC) VISIBLE,
  INDEX `fk_Seance_Crenau1_idx` (`Crenau_id` ASC) VISIBLE,
  CONSTRAINT `fk_Seance_Salle1`
    FOREIGN KEY (`Salle_id`)
    REFERENCES `cinemasql`.`Salle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plan_Seance_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `cinemasql`.`Film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plan_Seance_Langue1`
    FOREIGN KEY (`Langue_id`)
    REFERENCES `cinemasql`.`Langue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seance_Crenau1`
    FOREIGN KEY (`Crenau_id`)
    REFERENCES `cinemasql`.`Crenau` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Tarif`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Tarif` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Tarif` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Intitule` VARCHAR(45) NOT NULL,
  `Prix` DOUBLE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Personne`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Personne` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Personne` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Prenom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Acteur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Acteur` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Acteur` (
  `Personne_id` INT NOT NULL,
  PRIMARY KEY (`Personne_id`),
  INDEX `fk_Acteur_Personne1_idx` (`Personne_id` ASC) VISIBLE,
  CONSTRAINT `fk_Acteur_Personne1`
    FOREIGN KEY (`Personne_id`)
    REFERENCES `cinemasql`.`Personne` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Genre` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Intitule` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Realisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Realisateur` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Realisateur` (
  `Personne_id` INT NOT NULL,
  PRIMARY KEY (`Personne_id`),
  INDEX `fk_Realisateur_Personne1_idx` (`Personne_id` ASC) VISIBLE,
  CONSTRAINT `fk_Realisateur_Personne1`
    FOREIGN KEY (`Personne_id`)
    REFERENCES `cinemasql`.`Personne` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Film_has_Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Film_has_Genre` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Film_has_Genre` (
  `Film_id` INT NOT NULL,
  `Genre_id` INT NOT NULL,
  PRIMARY KEY (`Film_id`, `Genre_id`),
  INDEX `fk_Film_has_Genre_Genre1_idx` (`Genre_id` ASC) VISIBLE,
  INDEX `fk_Film_has_Genre_Film1_idx` (`Film_id` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Genre_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `cinemasql`.`Film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_Genre_Genre1`
    FOREIGN KEY (`Genre_id`)
    REFERENCES `cinemasql`.`Genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Billet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Billet` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Billet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Seance_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Seance_id`),
  INDEX `fk_Billet_Seance1_idx` (`Seance_id` ASC) VISIBLE,
  CONSTRAINT `fk_Billet_Seance1`
    FOREIGN KEY (`Seance_id`)
    REFERENCES `cinemasql`.`Seance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Film_has_Acteur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Film_has_Acteur` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Film_has_Acteur` (
  `Film_id` INT NOT NULL,
  `Acteur_id` INT NOT NULL,
  PRIMARY KEY (`Film_id`, `Acteur_id`),
  INDEX `fk_Film_has_Acteur_Film1_idx` (`Film_id` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Acteur_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `cinemasql`.`Film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Seance_has_Tarif`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Seance_has_Tarif` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Seance_has_Tarif` (
  `Seance_id` INT NOT NULL,
  `Tarif_id` INT NOT NULL,
  PRIMARY KEY (`Seance_id`, `Tarif_id`),
  INDEX `fk_Seance_has_Tarif_Tarif1_idx` (`Tarif_id` ASC) VISIBLE,
  INDEX `fk_Seance_has_Tarif_Seance1_idx` (`Seance_id` ASC) VISIBLE,
  CONSTRAINT `fk_Seance_has_Tarif_Seance1`
    FOREIGN KEY (`Seance_id`)
    REFERENCES `cinemasql`.`Seance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seance_has_Tarif_Tarif1`
    FOREIGN KEY (`Tarif_id`)
    REFERENCES `cinemasql`.`Tarif` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
