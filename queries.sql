-- Active: 1698408179226@@127.0.0.1@3306@cinemasql
DROP VIEW IF EXISTS sessions_plan_week;

DROP VIEW IF EXISTS sessions_plan_weekend;

DROP FUNCTION IF EXISTS format_movie_duration;

DROP VIEW IF EXISTS movie_summary;

DROP PROCEDURE IF EXISTS print_movie_summary;

-- -----------------------------------------------------
/*VIEW SEMAINE
Pour creer cette vue j'identifie les jours de la semaine avec la fonction DAYOFWEEK qui retourne un entier entre 1 et 7
je recupere les heures des seances et je les regroupe par creneaux de la semaine
puis je regroupe les salles par creneaux, le probleme est que je n'arrive pas a faire un un orderBy sur
les crenaux pour afficher matin apresmidi1 apresmidi2 soirée puis nuit, je les affiche donc dans l'ordre alphabetique.*/
-- -----------------------------------------------------


CREATE VIEW sessions_plan_week AS
SELECT
    CASE
        WHEN HOUR(c.Heure) <= 10 THEN 'Matin'
        WHEN HOUR(c.Heure) > 10 AND HOUR(c.Heure) <= 14 THEN 'Apresmidi1'
        WHEN HOUR(c.Heure) > 14 AND HOUR(c.Heure) <= 19 THEN 'Apresmidi2'
        WHEN HOUR(c.Heure) > 19 AND HOUR(c.Heure) <= 20 THEN 'Soirée'
        ELSE 'Nuit'
    END AS crenaux_semaine,
    GROUP_CONCAT(CONCAT('Salle ', s.id) ORDER BY s.id) AS salles
FROM
    Seance se
    INNER JOIN Salle s ON se.Salle_id = s.id
    INNER JOIN Crenau c ON se.Crenau_id = c.id
WHERE
    DAYOFWEEK(c.Date) >= 2
    AND DAYOFWEEK(c.Date) <= 6
GROUP BY
    crenaux_semaine;


CREATE VIEW
    sessions_plan_weekend AS
SELECT
    CASE
        WHEN HOUR (c.Heure) <= 10 THEN 'Matin'
        WHEN HOUR (c.Heure) > 10
        AND HOUR (c.Heure) <= 14 THEN 'Apresmidi1'
        WHEN HOUR (c.Heure) > 14
        AND HOUR (c.Heure) <= 19 THEN 'Apresmidi2'
        WHEN HOUR (c.Heure) > 19
        AND HOUR (c.Heure) <= 20 THEN 'Soirée'
        ELSE 'Nuit'
    END AS crenaux_weekend,
     GROUP_CONCAT(CONCAT('Salle ', s.id) ORDER BY s.id) AS salles
FROM
    Seance se
    INNER JOIN Salle s ON se.Salle_id = s.id
    INNER JOIN Crenau c ON se.Crenau_id = c.id
WHERE
    DAYOFWEEK (c.Date) = 1
    OR DAYOFWEEK (c.Date) = 7
GROUP BY
    crenaux_weekend;

 -- -----------------------------------------------------
-- Manipulation des données sur les films -----------------------------------------------------
-- J'ai un probleme d'import de csv lié a un probleme de 'secure_file_priv'
-- après plusieurs essais infructueux, je les rentre à la main ;
-- 2 -----------------------------------------------------
-- PERSONNE -----------------------------------------------------
-- -----------------------------------------------------

INSERT INTO Personne (Nom, Prenom) VALUES ('Jackson', 'Peter');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Plante', 'Pascal');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Triet', 'Justine');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Mortensen', 'Viggo');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('McKellen', 'Ian');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Wood', 'Elijah');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Gariépy', 'Juliette');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('McCabe-Lokos', 'Maxwell');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Arlaud', 'Swann');

INSERT INTO
    Personne (Nom, Prenom)
VALUES
    ('Machado Graner', 'Milo');

-- REALISATEUR -----------------------------------------------------
INSERT INTO Realisateur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Jackson' AND Prenom = 'Peter'));

INSERT INTO Realisateur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Plante' AND Prenom = 'Pascal'));

INSERT INTO Realisateur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Triet' AND Prenom = 'Justine'));

-- ACTEUR -----------------------------------------------------
INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Mortensen' AND Prenom = 'Viggo'));

INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'McKellen' AND Prenom = 'Ian'));

INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Wood' AND Prenom = 'Elijah'));

INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Gariépy' AND Prenom = 'Juliette'));

INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'McCabe-Lokos' AND Prenom = 'Maxwell'));

INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Arlaud' AND Prenom = 'Swann'));

INSERT INTO Acteur (Personne_id) VALUES ((SELECT id FROM Personne WHERE Nom = 'Machado Graner' AND Prenom = 'Milo'));


-- -----------------------------------------------------
-- 3 ---------------------------------------------------
-- -----------------------------------------------------

INSERT INTO
    FILM (
        `Titre`,
        `Date_sortie`,
        `Synopsis`,
        `Avant-Premiere`,
        `Duree_d'exploitation`,
        `Duree(Min)`,
        `Realisateur_id`,
        `LimiteAge_id`,
        `Commentaire`
    )
VALUES
    (
        "Le Seigneur des Anneaux : La Communauté de l'Anneau",
        2001,
        "Dans ce chapitre de la trilogie, le jeune et timide Hobbit, Frodon Sacquet, hérite d'un anneau. Bien loin d'être une simple babiole, il s'agit de l'Anneau Unique, un instrument de pouvoir absolu qui permettrait à Sauron, le Seigneur des ténèbres, de régner sur la Terre du Milieu et de réduire en esclavage ses peuples. Etc.",
        0,
        4,
        178,
        (
            SELECT id FROM Personne WHERE Nom = 'Jackson' AND Prenom = 'Peter'
        ),
        1,
        'Rétrospective'
    );

INSERT INTO
    FILM (
        `Titre`,
        `Date_sortie`,
        `Synopsis`,
        `Avant-Premiere`,
        `Duree_d'exploitation`,
        `Duree(Min)`,
        `Realisateur_id`,
        `LimiteAge_id`,
        `Commentaire`
    )
VALUES
    (
        'Le Seigneur des Anneaux : Les Deux Tours',
        2002,
        "Après la mort de Boromir et la disparition de Gandalf, la Communauté s'est scindée en trois. Perdus dans les collines d'Emyn Muil, Frodon et Sam découvrent qu'ils sont suivis par Gollum, une créature versatile corrompue par l'Anneau. Etc.",
        0,
        4,
        179,
        (
            SELECT id FROM Personne WHERE Nom = 'Jackson' AND Prenom = 'Peter'
        ),
        1,
        'Rétrospective'
    );

INSERT INTO
    FILM (
        `Titre`,
        `Date_sortie`,
        `Synopsis`,
        `Avant-Premiere`,
        `Duree_d'exploitation`,
        `Duree(Min)`,
        `Realisateur_id`,
        `LimiteAge_id`,
        `Commentaire`
    )
VALUES
    (
        'Le Seigneur des Anneaux : Le Retour du Roi',
        2003,
        "Les armées de Sauron ont attaqué Minas Tirith, la capitale de Gondor. Jamais ce royaume autrefois puissant n'a eu autant besoin de son roi. Mais Aragorn trouvera-t-il en lui la volonté d'accomplir sa destinée ? Etc.",
        0,
        4,
        201,
        (
            SELECT id FROM Personne WHERE Nom = 'Jackson' AND Prenom = 'Peter'
        ),
        1,
        'Rétrospective'
    );
INSERT INTO
    FILM (
        `Titre`,
        `Date_sortie`,
        `Synopsis`,
        `Avant-Premiere`,
        `Duree_d'exploitation`,
        `Duree(Min)`,
        `Realisateur_id`,
        `LimiteAge_id`,
        `Commentaire`
    )
VALUES
    (
        'Les chambres rouges',
        2024,
        "Deux jeunes femmes se réveillent chaque matin aux portes du palais de justice pour pouvoir assister au procès hypermédiatisé",
        1,
        2,
        118,
        (
            SELECT id FROM Personne WHERE Nom = 'Plante' AND Prenom = 'Pascal'
        ),
        3,
        'Rétrospective'
    );
INSERT INTO
    FILM (
        `Titre`,
        `Date_sortie`,
        `Synopsis`,
        `Avant-Premiere`,
        `Duree_d'exploitation`,
        `Duree(Min)`,
        `Realisateur_id`,
        `LimiteAge_id`,
        `Commentaire`
    )
VALUES
    (
        "Anatomie d'une chute",
        2023,
        "Sandra, Samuel et leur fils malvoyant de 11 ans, Daniel, vivent depuis un an loin de tout, à la montagne. Un jour, Samuel est etc.",
        0,
        6,
        150,
        (
            SELECT id FROM Personne WHERE Nom = 'Triet' AND Prenom = 'Justine'
        ),
        1,
        'Rétrospective'
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = "Le Seigneur des Anneaux : La Communauté de l'Anneau"
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Mortensen' AND Prenom = 'Viggo'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = "Le Seigneur des Anneaux : La Communauté de l'Anneau"
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'McKellen' AND Prenom = 'Ian'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = "Le Seigneur des Anneaux : La Communauté de l'Anneau"
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Wood' AND Prenom = 'Elijah'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Le Seigneur des Anneaux : les Deux Tours'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Mortensen' AND Prenom = 'Viggo'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Le Seigneur des Anneaux : les Deux Tours'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'McKellen' AND Prenom = 'Ian'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Le Seigneur des Anneaux : les Deux Tours'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Wood' AND Prenom = 'Elijah'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Le Seigneur des Anneaux : le Retour du Roi'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Mortensen' AND Prenom = 'Viggo'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Le Seigneur des Anneaux : le Retour du Roi'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'McKellen' AND Prenom = 'Ian'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Le Seigneur des Anneaux : le Retour du Roi'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Wood' AND Prenom = 'Elijah'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Les chambres rouges'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Gariépy' AND Prenom = 'Juliette'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = 'Les chambres rouges'
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'McCabe-Lokos' AND Prenom = 'Maxwell'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = "Anatomie d'une chute"
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Arlaud' AND Prenom = 'Swann'
        )
    );

INSERT INTO
    film_has_acteur (Film_id, Acteur_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                FILM
            WHERE
                Titre = "Anatomie d'une chute"
        ),
        (
            SELECT id FROM Personne WHERE Nom = 'Machado Graner' AND Prenom = 'Milo'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Le Seigneur des Anneaux : la Communauté de l''Anneau'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Fantastique'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Le Seigneur des Anneaux : la Communauté de l''Anneau'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Famille'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Le Seigneur des Anneaux : le Retour du Roi'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Fantastique'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Le Seigneur des Anneaux : le Retour du Roi'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Famille'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Le Seigneur des Anneaux : les Deux Tours'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Fantastique'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Le Seigneur des Anneaux : les Deux Tours'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Famille'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = 'Les chambres rouges'
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Thriller'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = "Anatomie d'une chute"
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Drame'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = "Anatomie d'une chute"
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Thriller'
        )
    );

INSERT INTO
    film_has_genre (Film_id, Genre_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                Film
            WHERE
                Titre = "Anatomie d'une chute"
        ),
        (
            SELECT
                id
            FROM
                Genre
            WHERE
                Intitule = 'Policier'
        )
    );

-- -----------------------------------------------------
-- 4 ---------------------------------------------------
-- -----------------------------------------------------

SELECT
    Titre AS "Films réalisés par Peter Jackson"
FROM
    Film
    INNER JOIN Realisateur ON Film.Realisateur_id = Realisateur.Personne_id
    INNER JOIN Personne ON Realisateur.Personne_id = Personne.id
WHERE
    Personne.Nom = 'Jackson'
    AND Personne.Prenom = 'Peter'
ORDER BY
    Date_sortie ASC;

-- -----------------------------------------------------
-- 5 ---------------------------------------------------
-- -----------------------------------------------------

SELECT
    f.Titre AS "Films dans lesquels a joué Viggo Mortensen"
FROM
    Film f
    JOIN film_has_acteur fa ON f.id = fa.Film_id
    JOIN Acteur a ON fa.Acteur_id = a.Personne_id
    JOIN Personne p ON a.Personne_id = p.id
WHERE
    p.Nom = 'Mortensen'
    AND p.Prenom = 'Viggo';


-- -----------------------------------------------------
-- 6 ---------------------------------------------------
/*Au depart j'avais fait deux fois les memes jointures pour les deux acteurs ce qui fonctionnait
mais cette methode et plus claire.*/
-- -----------------------------------------------------


SELECT
    f.Titre AS "Films dans lesquels apparaissent Viggo Mortensen et Ian McKellen"
FROM
    Film f
    JOIN film_has_acteur fa ON f.id = fa.Film_id
    JOIN Acteur a ON fa.Acteur_id = a.Personne_id
    JOIN Personne p ON a.Personne_id = p.id
WHERE
    (p.Nom = 'Mortensen' AND p.Prenom = 'Viggo')
    OR (p.Nom = 'McKellen' AND p.Prenom = 'Ian')
GROUP BY
    f.id,
    f.Titre
HAVING
    COUNT(DISTINCT p.id) = 2;

-- Affiches / Fiches de film -----------------------------------------------------

-- -----------------------------------------------------
-- 7 ---------------------------------------------------
-- -----------------------------------------------------

DELIMITER //

CREATE FUNCTION format_movie_duration(duration_in_min INT) RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE formatted_duration VARCHAR(10);

    SET hours = duration_in_min DIV 60;
    SET minutes = duration_in_min MOD 60;
    SET formatted_duration = CONCAT(hours, 'h', LPAD(minutes, 2, '0'));

    RETURN formatted_duration;
END //

DELIMITER ;

-- -----------------------------------------------------
-- Exemple d'utilisation :
-- -----------------------------------------------------

SELECT format_movie_duration (133);

-- -----------------------------------------------------
-- 8 ---------------------------------------------------
-- -----------------------------------------------------

SELECT
    f.Titre AS Titre,
    f.Synopsis AS Synopsis,
    CONCAT(p.Nom, ' ', p.Prenom) AS Realisateur_ice,
    GROUP_CONCAT(CONCAT(pa.Nom, ' ', pa.Prenom) SEPARATOR ', ') AS Acteurs_ices,
    CONCAT(f.`Duree(Min)` DIV 60, 'h', LPAD(f.`Duree(Min)` MOD 60, 2, '0')) AS Duree_du_film,
    GROUP_CONCAT(g.Intitule SEPARATOR ', ') AS Genres,
    la.Intitule AS Public,
    f.Commentaire AS Commentaire
FROM
    Film f
    JOIN Personne p ON f.Realisateur_id = p.id
    JOIN Film_has_Acteur fa ON f.id = fa.Film_id
    JOIN Acteur a ON fa.Acteur_id = a.Personne_id
    JOIN Personne pa ON a.Personne_id = pa.id
    JOIN Film_has_Genre fg ON f.id = fg.Film_id
    JOIN Genre g ON fg.Genre_id = g.id
    JOIN LimiteAge la ON f.LimiteAge_id = la.id
WHERE
    f.Titre = "Anatomie d'une chute"
GROUP BY
    f.Titre,
    f.Synopsis,
    p.Nom,
    p.Prenom,
    f.`Duree(Min)`,
    la.Intitule,
    f.Commentaire;



CREATE VIEW
    movie_summary AS
SELECT
    f.Titre AS Titre,
    f.Synopsis AS Synopsis,
    CONCAT(p.Nom, ' ', p.Prenom) AS Realisateur_ice,
    GROUP_CONCAT(CONCAT(pa.Nom, ' ', pa.Prenom) SEPARATOR ', ') AS Acteurs_ices,
    CONCAT(f.`Duree(Min)` DIV 60, 'h', LPAD(f.`Duree(Min)` MOD 60, 2, '0')) AS Duree_du_film,
    GROUP_CONCAT(g.Intitule SEPARATOR ', ') AS Genres,
    la.Intitule AS Public,
    f.Commentaire AS Commentaire
FROM
    Film f
    JOIN Realisateur r ON f.Realisateur_id = r.Personne_id
    JOIN Personne p ON r.Personne_id = p.id
    JOIN Film_has_Acteur fa ON f.id = fa.Film_id
    JOIN Acteur a ON fa.Acteur_id = a.Personne_id
    JOIN Personne pa ON a.Personne_id = pa.id
    JOIN Film_has_Genre fg ON f.id = fg.Film_id
    JOIN Genre g ON fg.Genre_id = g.id
    JOIN LimiteAge la ON f.LimiteAge_id = la.id
GROUP BY
    f.Titre,
    f.Synopsis,
    p.Nom,
    p.Prenom,
    f.`Duree(Min)`,
    la.Intitule,
    f.Commentaire;


-- -----------------------------------------------------
-- 9 ---------------------------------------------------
-- -----------------------------------------------------

DELIMITER //

CREATE PROCEDURE print_movie_summary (IN movie_title VARCHAR(100))
BEGIN
    SELECT
        *
    FROM
        movie_summary
    WHERE
        Titre = movie_title;
END //

DELIMITER ;

-- ---------------------------------------------------
-- Exemple d'utilisation :
-- ---------------------------------------------------

CALL print_movie_summary ("Anatomie d'une chute");

-- PROGRAMATION -----------------------------------------------------

-- -----------------------------------------------------
-- 10 ---------------------------------------------------
-- -----------------------------------------------------

-- Program "Le Seigneur des Anneaux : La communauté de l'anneau" en VF sur toutes les séances Matin (semaine et weekend) dans la Salle 01

INSERT INTO
    Seance (Film_id, Langue_id, Salle_id, Crenau_id)
SELECT
    (
        SELECT
            id
        FROM
            Film
        WHERE
            Titre = "Le Seigneur des Anneaux : La communauté de l'anneau"
    ) AS Film_id,
    (
        SELECT
            id
        FROM
            Langue
        WHERE
            Langue = 'VF'
    ) AS Langue_id,
    (
        SELECT
            id
        FROM
            Salle
        WHERE
            id = '01'
    ) AS Salle_id,
    Crenau.id AS Crenau_id
FROM
    Crenau
WHERE
    HOUR (Crenau.Heure) >= 9
    AND HOUR (Crenau.Heure) < 12;

-- Program "Anatomie d'une chute" en VF sur toutes les séances Après-Midi 2 de la semaine et Soirée du weekend dans la Salle 03

INSERT INTO
    Seance (Film_id, Langue_id, Salle_id, Crenau_id)
SELECT
    (
        SELECT
            id
        FROM
            Film
        WHERE
            Titre = "Anatomie d'une chute"
    ) AS Film_id,
    (
        SELECT
            id
        FROM
            Langue
        WHERE
            Langue = 'VF'
    ) AS Langue_id,
    (
        SELECT
            id
        FROM
            Salle
        WHERE
            id = '03'
    ) AS Salle_id,
    Crenau.id AS Crenau_id
FROM
    Crenau
WHERE
    (
        (
            WEEKDAY (Crenau.Date) < 5
            AND HOUR (Crenau.Heure) >= 14
            AND HOUR (Crenau.Heure) < 18
        )
        OR (
            WEEKDAY (Crenau.Date) >= 5
            AND HOUR (Crenau.Heure) >= 18
        )
    );

-- -----------------------------------------------------
-- 11 ---------------------------------------------------
-- -----------------------------------------------------

SELECT
    f.Titre AS Film,
    l.Langue AS Langue,
    c.Date AS Date,
    c.Heure AS Heure,
    s.Salle_id AS Salle,
    CASE
        WHEN DAYOFWEEK(c.Date) BETWEEN 2 AND 6 THEN 'Semaine'
        WHEN DAYOFWEEK(c.Date) IN (1, 7) THEN 'Weekend'
    END AS Creneaux
FROM
    Seance s
    INNER JOIN Film f ON s.Film_id = f.id
    INNER JOIN Crenau c ON s.Crenau_id = c.id
    INNER JOIN Langue l ON s.Langue_id = l.id
WHERE
    DAYOFWEEK(c.Date) BETWEEN 1 AND 7
ORDER BY
    f.Titre ASC,
    c.Date ASC,
    c.Heure ASC;

-- -----------------------------------------------------
-- 12 ---------------------------------------------------
-- -----------------------------------------------------

SELECT
    b.id AS numero_ticket,
    f.Titre AS film,
    c.Date AS date,
    'Version originale' AS version,
    t.Prix AS prix,
    c.Heure AS Heure,
    s.Salle_id AS Salle
FROM
    Billet b
    INNER JOIN Seance s ON b.Seance_id = s.id
    INNER JOIN Film f ON s.Film_id = f.id
    INNER JOIN Crenau c ON s.Crenau_id = c.id
    INNER JOIN Seance_has_Tarif sht ON sht.Seance_id = s.id
    INNER JOIN Tarif t ON sht.Tarif_id = t.id;

-- -----------------------------------------------------
-- 13 ---------------------------------------------------
-- -----------------------------------------------------

SELECT
    s.Salle_id,
    (
        SELECT
            Nb_Places
        FROM
            Salle
        WHERE
            id = s.Salle_id
        ) - COUNT(*) AS places_restantes
FROM
    Billet b
    INNER JOIN Seance s ON b.Seance_id = s.id
    INNER JOIN Crenau c ON s.Crenau_id = c.id
WHERE
    DATE (c.Date) = '2024-02-23'
GROUP BY
    s.Salle_id;

-- -----------------------------------------------------
-- 14 ---------------------------------------------------
-- -----------------------------------------------------

-- Il faut creer un trigger qui empeche la creation d'une seance si la salle est deja occupée par un film qui chevauche les horaires.