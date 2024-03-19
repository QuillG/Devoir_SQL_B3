-- -----------------------------------------------------
-- Schema cinemasql
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cinemasql` ;

-- -----------------------------------------------------
-- Schema cinemasql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinemasql` DEFAULT CHARACTER SET utf8 ;
USE `cinemasql` ;

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
-- Table `cinemasql`.`Personne`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Personne` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Personne` (
  `id` INT NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Prénom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Réalisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Réalisateur` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Réalisateur` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Personne_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Personne_id`),
  INDEX `fk_Réalisateur_Personne1_idx` (`Personne_id` ASC) VISIBLE,
  CONSTRAINT `fk_Réalisateur_Personne1`
    FOREIGN KEY (`Personne_id`)
    REFERENCES `cinemasql`.`Personne` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`LimiteAge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`LimiteAge` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`LimiteAge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Intitulé` VARCHAR(45) NOT NULL,
  `Age_Mini` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Tarif`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Tarif` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Tarif` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Intitulé` VARCHAR(45) NOT NULL,
  `Prix` DOUBLE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Film` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Film` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Titre` VARCHAR(100) NOT NULL,
  `Durée` VARCHAR(45) NOT NULL,
  `Date de sortie` DATE NOT NULL,
  `Synopsis` LONGTEXT NOT NULL,
  `Commentaire additionnel` MEDIUMTEXT NULL,
  `Avant-Première` TINYINT NOT NULL,
  ` durée_d'exploitation` INT NOT NULL DEFAULT 8,
  `Version_id` INT NOT NULL,
  `Réalisateur_id` INT NOT NULL,
  `LimiteAge_id` INT NOT NULL,
  `Tarif_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Film_Réalisateur1_idx` (`Réalisateur_id` ASC) VISIBLE,
  INDEX `fk_Film_LimiteAge1_idx` (`LimiteAge_id` ASC) VISIBLE,
  INDEX `fk_Film_Tarif1_idx` (`Tarif_id` ASC) VISIBLE,
  CONSTRAINT `fk_Film_Réalisateur1`
    FOREIGN KEY (`Réalisateur_id`)
    REFERENCES `cinemasql`.`Réalisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_LimiteAge1`
    FOREIGN KEY (`LimiteAge_id`)
    REFERENCES `cinemasql`.`LimiteAge` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Tarif1`
    FOREIGN KEY (`Tarif_id`)
    REFERENCES `cinemasql`.`Tarif` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Date` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Date` (
  `id` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Plan_Seance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Plan_Seance` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Plan_Seance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Salle_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `Date_id` INT NOT NULL,
  `Langue_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Seance_Salle1_idx` (`Salle_id` ASC) VISIBLE,
  INDEX `fk_Plan_Seance_Film1_idx` (`Film_id` ASC) VISIBLE,
  INDEX `fk_Plan_Seance_Date1_idx` (`Date_id` ASC) VISIBLE,
  INDEX `fk_Plan_Seance_Langue1_idx` (`Langue_id` ASC) VISIBLE,
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
  CONSTRAINT `fk_Plan_Seance_Date1`
    FOREIGN KEY (`Date_id`)
    REFERENCES `cinemasql`.`Date` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plan_Seance_Langue1`
    FOREIGN KEY (`Langue_id`)
    REFERENCES `cinemasql`.`Langue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinemasql`.`Acteur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemasql`.`Acteur` ;

CREATE TABLE IF NOT EXISTS `cinemasql`.`Acteur` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Personne_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Personne_id`),
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
  `Intitulé` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
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
  `Tarif_id` INT NOT NULL,
  `Seance_id` INT NOT NULL,
  `Salle_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Tarif_id`, `Seance_id`, `Salle_id`),
  INDEX `fk_Billet_Tarif1_idx` (`Tarif_id` ASC) VISIBLE,
  INDEX `fk_Billet_Seance1_idx` (`Seance_id` ASC) VISIBLE,
  INDEX `fk_Billet_Salle1_idx` (`Salle_id` ASC) VISIBLE,
  CONSTRAINT `fk_Billet_Tarif1`
    FOREIGN KEY (`Tarif_id`)
    REFERENCES `cinemasql`.`Tarif` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Billet_Seance1`
    FOREIGN KEY (`Seance_id`)
    REFERENCES `cinemasql`.`Plan_Seance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Billet_Salle1`
    FOREIGN KEY (`Salle_id`)
    REFERENCES `cinemasql`.`Salle` (`id`)
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
  INDEX `fk_Film_has_Acteur_Acteur1_idx` (`Acteur_id` ASC) VISIBLE,
  INDEX `fk_Film_has_Acteur_Film1_idx` (`Film_id` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Acteur_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `cinemasql`.`Film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_Acteur_Acteur1`
    FOREIGN KEY (`Acteur_id`)
    REFERENCES `cinemasql`.`Acteur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

