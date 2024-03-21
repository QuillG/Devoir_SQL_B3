-- Active: 1698408179226@@127.0.0.1@3306@cinemasql
-- DROP -----------------------------------------------------
DELETE FROM seance_has_tarif;
DELETE FROM seance;
DELETE FROM Crenau;
DELETE FROM Film_has_Genre;
DELETE FROM Film_has_Acteur;
DELETE FROM Film;
DELETE FROM Acteur;
DELETE FROM Realisateur;
DELETE FROM Personne;
DELETE FROM Tarif;
DELETE FROM limiteage;
DELETE FROM Genre;
DELETE FROM Langue;
DELETE FROM Salle;

-- SALLE -----------------------------------------------------

INSERT INTO `cinemasql`.`Salle` (`Nb_Places`) VALUES (100);
INSERT INTO `cinemasql`.`Salle` (`Nb_Places`) VALUES (150);
INSERT INTO `cinemasql`.`Salle` (`Nb_Places`) VALUES (200);

-- LANGUE -----------------------------------------------------
INSERT INTO `cinemasql`.`Langue` (`Langue`) VALUES ('VF');
INSERT INTO `cinemasql`.`Langue` (`Langue`) VALUES ('VO');

-- Genre -----------------------------------------------------
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Drame');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Comédie');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Aventure');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Science-fiction');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Horreur');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Fantastique');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Policier');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Thriller');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Action');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Animation');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Romance');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Famille');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Comédie dramatique');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Documentaire');
INSERT INTO `cinemasql`.`Genre` (`Intitule`) VALUES ('Western');

-- PEGI -----------------------------------------------------
INSERT INTO `cinemasql`.`limiteage` (`Intitule`, `Age_Mini`) VALUES ('Tous publics', 0);
INSERT INTO `cinemasql`.`limiteage` (`Intitule`, `Age_Mini`) VALUES ('- 10 ans', 10);
INSERT INTO `cinemasql`.`limiteage` (`Intitule`, `Age_Mini`) VALUES ('- 12 ans', 12);
INSERT INTO `cinemasql`.`limiteage` (`Intitule`, `Age_Mini`) VALUES ('- 16 ans', 16);
INSERT INTO `cinemasql`.`limiteage` (`Intitule`, `Age_Mini`) VALUES ('- 18 ans', 18);


-- TARIFS -----------------------------------------------------
INSERT INTO `cinemasql`.`Tarif` (`Intitule`, `Prix`) VALUES ('Plein', 9.80);
INSERT INTO `cinemasql`.`Tarif` (`Intitule`, `Prix`) VALUES ('Étudiant', 5.00);
INSERT INTO `cinemasql`.`Tarif` (`Intitule`, `Prix`) VALUES ('Demandeur d’emploi', 5.00);
INSERT INTO `cinemasql`.`Tarif` (`Intitule`, `Prix`) VALUES ('- 14 ans', 3.80);

-- PERSONNES -----------------------------------------------------
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Spielberg', 'Steven');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Lucas', 'George');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Cameron', 'James');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Coppola', 'Francis Ford');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Scorsese', 'Martin');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Tarantino', 'Quentin');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Nolan', 'Christopher');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Cruise', 'Tom');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Pitt', 'Brad');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('DiCaprio', 'Leonardo');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Roberts', 'Julia');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Kidman', 'Nicole');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Jolie', 'Angelina');

-- REALISATEURS -----------------------------------------------------
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (1);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (2);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (3);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (4);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (5);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (6);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (7);
INSERT INTO `cinemasql`.`Realisateur` (`Personne_id`) VALUES (8);

-- ACTEURS -----------------------------------------------------
INSERT INTO `cinemasql`.`Acteur` (Personne_id) VALUES (8);
INSERT INTO `cinemasql`.`Acteur` (Personne_id) VALUES (9);
INSERT INTO `cinemasql`.`Acteur` (Personne_id) VALUES (10);
INSERT INTO `cinemasql`.`Acteur` (Personne_id) VALUES (11);
INSERT INTO `cinemasql`.`Acteur` (Personne_id) VALUES (12);
INSERT INTO `cinemasql`.`Acteur` (Personne_id) VALUES (13);

-- FILMS -----------------------------------------------------
INSERT INTO `cinemasql`.`Film` (`Titre`, `Date_sortie`, `Synopsis`, `Avant-Premiere`, `Duree_d'exploitation`, `Duree(min)`, `Realisateur_id`, `LimiteAge_id`, `Commentaire`) VALUES ('Jurassic Park', '1993', 'Des dinosaures génétiquement modifiés sèment la terreur dans un parc d’attractions.', 0, 8, '125', 1, 2, 'Le film a été un énorme succès commercial et a remporté de nombreux prix.');
INSERT INTO `cinemasql`.`Film` (`Titre`, `Date_sortie`, `Synopsis`, `Avant-Premiere`, `Duree_d'exploitation`, `Duree(min)`, `Realisateur_id`, `LimiteAge_id`, `Commentaire`) VALUES ('Star Wars', '1977', 'Dans une galaxie lointaine, très lointaine, un groupe de rebelles combat l’Empire.', 0, 8, '121', 2, 2, 'Le film a été un énorme succès commercial et a remporté de nombreux prix.');

-- FILM_HAS_ACTEUR -----------------------------------------------------
INSERT INTO `cinemasql`.`Film_has_Acteur` (`Film_id`, `Acteur_id`) VALUES (1, 1);
INSERT INTO `cinemasql`.`Film_has_Acteur` (`Film_id`, `Acteur_id`) VALUES (1, 2);

-- FILM_HAS_GENRE -----------------------------------------------------
INSERT INTO `cinemasql`.`Film_has_Genre` (`Film_id`, `Genre_id`) VALUES (1, 3);
INSERT INTO `cinemasql`.`Film_has_Genre` (`Film_id`, `Genre_id`) VALUES (1, 4);

-- Crenau -----------------------------------------------------
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-23', '10:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-23', '14:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-23', '18:15');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-23', '20:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-23', '22:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-25', '10:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-25', '14:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-25', '18:15');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-25', '20:00');
INSERT INTO `cinemasql`.`Crenau` (`Date`, `Heure`) VALUES ('2024-02-25', '22:00');

-- SEANCE -----------------------------------------------------
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (1, 1, 1, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (2, 1, 1, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (3, 1, 1, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (4, 1, 1, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (5, 1, 1, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (1, 2, 2, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (2, 2, 2, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (3, 2, 2, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (4, 2, 2, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (5, 2, 2, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (6, 1, 3, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (7, 1, 3, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (8, 1, 3, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (9, 1, 3, 1);
INSERT INTO `cinemasql`.`seance` (`Crenau_id`, `Film_id`, `Salle_id`, `Langue_id`) VALUES (10, 1, 3, 1);

-- SEANCE_HAS_TARIF ---------------------------------------------------
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (1, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (2, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (3, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (4, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (5, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (6, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (7, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (8, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (9, 1);
INSERT INTO `cinemasql`.`seance_has_tarif` (`Seance_id`, `Tarif_id`) VALUES (10, 1);

-- BILLET -----------------------------------------------------

INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (1);
INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (2);
INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (3);
INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (4);
INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (5);
INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (6);
INSERT INTO `cinemasql`.`Billet` (`Seance_id`) VALUES (7);















