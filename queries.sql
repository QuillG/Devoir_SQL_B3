-- Active: 1698408179226@@127.0.0.1@3306@cinemasql

DROP VIEW IF EXISTS sessions_plan_week;
DROP VIEW IF EXISTS sessions_plan_weekend;
-- VIEW SEMAINE-----------------------------------------------------

-- Pour creer cette vue j'identifie les jours de la semaine avec la fonction DAYOFWEEK qui retourne un entier entre 1 et 7
-- je recupere les heures des seances et je les regroupe par creneaux de la semaine
-- puis je regroupe les salles par creneaux, le probleme est que je n'arrive pas a faire un un orderBy sur
-- les crenaux pour afficher matin apresmidi1 apresmidi2 soirée puis nuit, je les affiche donc dans l'ordre alphabetique.

CREATE VIEW sessions_plan_week AS
SELECT
    CASE
        WHEN HOUR(c.Heure) <= 10 THEN 'Matin'
        WHEN HOUR(c.Heure) > 10 AND HOUR(c.Heure) <= 14 THEN 'Apresmidi1'
        WHEN HOUR(c.Heure) > 14 AND HOUR(c.Heure) <= 19 THEN 'Apresmidi2'
        WHEN HOUR(c.Heure) > 19 AND HOUR(c.Heure) <= 20 THEN 'Soirée'
        ELSE 'Nuit'
    END AS crenaux_semaine,
    GROUP_CONCAT(CONCAT('Salle ', LPAD(s.id, 2, '0')) ORDER BY s.id) AS salles
FROM
    Seance se
INNER JOIN
    Salle s ON se.Salle_id = s.id
INNER JOIN
    Crenau c ON se.Crenau_id = c.id
WHERE
    DAYOFWEEK(c.Date) >= 2 AND DAYOFWEEK(c.Date) <= 6
GROUP BY
    crenaux_semaine;

-- VIEW WEEKEND-----------------------------------------------------
CREATE VIEW sessions_plan_weekend AS
SELECT
    CASE
        WHEN HOUR(c.Heure) <= 10 THEN 'Matin'
        WHEN HOUR(c.Heure) > 10 AND HOUR(c.Heure) <= 14 THEN 'Apresmidi1'
        WHEN HOUR(c.Heure) > 14 AND HOUR(c.Heure) <= 19 THEN 'Apresmidi2'
        WHEN HOUR(c.Heure) > 19 AND HOUR(c.Heure) <= 20 THEN 'Soirée'
        ELSE 'Nuit'
    END AS crenaux_weekend,
    GROUP_CONCAT(CONCAT('Salle ', LPAD(s.id, 2, '0')) ORDER BY s.id) AS salles
FROM
    Seance se
INNER JOIN
    Salle s ON se.Salle_id = s.id
INNER JOIN
    Crenau c ON se.Crenau_id = c.id
WHERE
    DAYOFWEEK(c.Date) = 1 OR DAYOFWEEK(c.Date) = 7
GROUP BY
    crenaux_weekend;

-- Manipulation des données sur les films -----------------------------------------------------

-- Les colonnes de ma table film differe du fichier film.csv, je vais donc devoir importer via des insertions

-- 2

-- PERSONNE -----------------------------------------------------

INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Jackson', 'Peter');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Plante', 'Pascal');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Triet', 'Justine');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Wood', 'Elijah');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('McKellen', 'Ian');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Mortensen', 'Viggo');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('McCabe-Lokos', 'Maxwell');
INSERT INTO `cinemasql`.`Personne` (`Nom`, `Prenom`) VALUES ('Gariépy', 'Juliette');

















--4

SELECT Titre
FROM Film
INNER JOIN Realisateur ON Film.Réalisateur_id = Realisateur.id
INNER JOIN Personne ON Realisateur.Personne_id = Personne.id
WHERE Personne.Nom = 'Jackson' AND Personne.Prenom = 'Peter'
ORDER BY Date_sortie ASC;

--5

SELECT Titre
FROM Film
INNER JOIN Acteur ON Film.id = Acteur.Film_id
INNER JOIN Personne ON Acteur.Personne_id = Personne.id
WHERE Personne.Nom = 'Mortensen' AND Personne.Prenom = 'Viggo';

--6 
SELECT Titre
FROM Film
INNER JOIN Acteur ON Film.id = Acteur.Film_id
INNER JOIN Personne ON Acteur.Personne_id = Personne.id
WHERE Personne.Nom = 'Mortensen' AND Personne.Prenom = 'Viggo'
AND Personne.Nom = 'McKellen' AND Personne.Prenom = 'Ian';

--Affiches / Fiches de film -----------------------------------------------------

--7

CREATE FUNCTION format_movie_duration(duration_in_min INT)
RETURNS VARCHAR(5)
BEGIN
    DECLARE h INT;
    DECLARE m INT;
    SET h = duration_in_min DIV 60;
    SET m = duration_in_min MOD 60;
    RETURN CONCAT(h, 'h', LPAD(m, 2, '0'));
END;

--8

-- SELECT
--     f.Titre,
--     f.Synopsis,
--     CONCAT(p.Nom, ' ', p.Prenom) AS Realisateur,
--     GROUP_CONCAT(CONCAT(pa.Nom, ' ', pa.Prenom) ORDER BY pa.Nom, pa.Prenom) AS Acteurs,
--     format_movie_duration(f.Duree) AS Duree,
--     GROUP_CONCAT(g.Nom ORDER BY g.Nom) AS Genres,
--     f.Public,
--     f.Commentaire
-- FROM
--     Film f
-- INNER JOIN
--     Realisateur r ON f.Réalisateur_id = r.id
-- INNER JOIN
--     Personne p ON r.Personne_id = p.id
-- INNER JOIN
--     Acteur a ON f.id = a.Film_id
-- INNER JOIN
--     Personne pa ON a.Personne_id = pa.id
-- INNER JOIN
--     Film_has_Genre fg ON f.id = fg.Film_id
-- INNER JOIN
--     Genre g ON fg.Genre_id = g.id
-- WHERE
--     f.Titre = 'Jurassic Park'
-- GROUP BY
--     f.Titre, f.Synopsis, Realisateur, Duree, f.Public, f.Commentaire;











