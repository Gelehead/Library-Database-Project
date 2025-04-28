
-- Création des tables
CREATE TABLE adherent (
  id_adh       SERIAL PRIMARY KEY,
  nom          VARCHAR(255) NOT NULL,
  prenom       VARCHAR(255) NOT NULL,
  adresse      TEXT         NOT NULL
);

CREATE TABLE auteur (
  id_auteur    SERIAL PRIMARY KEY,
  nom          VARCHAR(100) NOT NULL,
  prenom       VARCHAR(100) NOT NULL
);

CREATE TABLE livre (
  id_livre     SERIAL PRIMARY KEY,
  isbn         VARCHAR(13),
  titre        VARCHAR(255) NOT NULL,
  genre        VARCHAR(50)  NOT NULL,
  id_auteur    INTEGER      NOT NULL,
  FOREIGN KEY (id_auteur)
    REFERENCES auteur(id_auteur)
);

CREATE TABLE exemplaire (
  id_Livre     SERIAL PRIMARY KEY,
  isbn         VARCHAR(13) NOT NULL,
  FOREIGN KEY(id_Livre)
    REFERENCES livre(id_Livre)
);

CREATE TABLE emprunt (
  id_emprunt    SERIAL PRIMARY KEY,
  id_livre      INTEGER   NOT NULL REFERENCES exemplaire(id_livre),
  id_adh        INTEGER   NOT NULL REFERENCES adherent(id_adh),
  date_emprunt  DATE      NOT NULL,
  date_retour   DATE      NOT NULL,
  CHECK (date_retour > date_emprunt),
   CHECK (date_retour <= date(date_emprunt, '+14 days'))
);

CREATE TABLE commande (
  id_commande   SERIAL PRIMARY KEY,
  id_livre      INTEGER   NOT NULL REFERENCES exemplaire(id_livre),
  id_adh        INTEGER      NOT NULL REFERENCES adherent(id_adh),
  date_commande DATE         NOT NULL,
  statut        VARCHAR(20)  NOT NULL
  CHECK (statut IN ('en attente','honorée','annulée'))
);

-- Auteurs
INSERT INTO auteur (nom, prenom) VALUES
('Dupont','Jean'),
('Martin','Marie'),
('Durand','Pierre'),
('Leroy','Sophie'),
('Moreau','Luc'),
('Fournier','Emma'),
('Girard','Louis'),
('Petit','Chloé'),
('Rousseau','Paul'),
('David','Emma'),
('Bernard','Alice');

-- Adhérents
INSERT INTO adherent (nom, prenom, adresse) VALUES
('Leclerc','Anne','123 Rue Principale, Montréal'),
('Gagnon','Marc','456 Av. des Pins, Montréal'),
('Thibault','Julie','789 Boul. St‑Laure, Laval'),
('Roche','Claire','321 Rue St‑Joseph, Québec'),
('Beaulieu','Nicolas','654 Av. Duplessis, Longueuil'),
('Tremblay','Lucie','987 Rue St‑Paul, Gatineau'),
('Lapointe','Simon','147 Rue Lajoie, Sherbrooke'),
('Caron','Sandrine','258 Chemin du Lac, Trois‑Rivières'),
('Fortin','Olivier','369 Rue Dorchester, Gatineau'),
('Cloutier','Élise','741 Av. de l''Université, Montréal'),
('Simard','Kévin','852 Rue Wellington, Montréal');

-- Livres
INSERT INTO livre (isbn, titre, genre, id_auteur) VALUES
('9781234567897','Le Petit Prince','Conte',           1),
('9782345678901','Les Misérables','Roman',            2),
('9783456789012','1984','Dystopie',                   3),
('9784567890123','La Peste','Roman',                  4),
('9785678901234','Le Rouge et le Noir','Roman',       5),
('9786789012345','Harry Potter à l''école des sorciers','Fantasy',6),
('9787890123456','Le Seigneur des Anneaux','Fantasy', 7),
('9788901234567','Le Comte de Monte‑Cristo','Aventure',8),
('9789012345678','Le Journal d''Anne Frank','Biographie',9),
('9780123456789','Cien años de soledad','Roman',      10),
('9781122334455','Alice au pays des merveilles','Conte',11);

-- Exemplaires
INSERT INTO exemplaire (isbn) VALUES
('9781234567897'),('9781234567897'),
('9782345678901'),('9782345678901'),
('9783456789012'),('9783456789012'),
('9784567890123'),
('9785678901234'),
('9786789012345'),('9786789012345'),
('9787890123456'),
('9788901234567'),
('9789012345678'),
('9780123456789'),
('9781122334455');

-- Commandes
INSERT INTO commande (id_livre, id_adh, date_commande, statut) VALUES
(1, 1,'2025-04-01','en attente'),
(3, 2,'2025-04-02','honorée'),
(5, 3,'2025-04-03','en attente'),
(7, 4,'2025-04-04','annulée'),
(8, 5,'2025-04-05','honorée'),
(9, 6,'2025-04-06','en attente'),
(11, 7,'2025-04-07','honorée'),
(12, 8,'2025-04-08','en attente'),
(13, 9,'2025-04-09','honorée'),
(14, 10,'2025-04-10','honorée'),
(15, 11,'2025-04-11','en attente');

-- Emprunts
INSERT INTO emprunt (id_livre, id_adh, date_emprunt, date_retour) VALUES
(1, 1,'2025-03-15','2025-03-25'),
(2, 2,'2025-03-16','2025-03-26'),
(3, 3,'2025-03-17','2025-03-27'),
(4, 4,'2025-03-18','2025-03-28'),
(5, 5,'2025-03-19','2025-03-29'),
(6, 6,'2025-03-20','2025-03-30'),
(7, 7,'2025-03-21','2025-03-31'),
(8, 8,'2025-03-22','2025-04-01'),
(9, 9,'2025-03-23','2025-04-02'),
(10, 10,'2025-03-24','2025-04-03'),
(11, 11,'2025-03-25','2025-04-04');

--Quelles sont les tendances selon les dernières décénies
WITH mois_annee AS (
    -- Génère une série de dates pour tous les mois entre la première et la dernière date d'emprunt
    SELECT 
        generate_series(
            DATE_TRUNC('month', (SELECT MIN(date_emprunt) FROM emprunt)),
            DATE_TRUNC('month', (SELECT MAX(date_emprunt) FROM emprunt)),
            '1 month'
        ) AS premier_jour_mois
),
emprunts_mensuels AS (
    -- Compte le nombre d'emprunts par mois et par genre
    SELECT 
        DATE_TRUNC('month', e.date_emprunt) AS mois,
        l.genre,
        COUNT(*) AS nombre_emprunts
    FROM 
        emprunt e
        JOIN exemplaire ex ON e.id_livre = ex.id_livre
        JOIN livre l ON ex.isbn = l.isbn
    GROUP BY 
        mois, l.genre
),
stats_completes AS (
    -- Combine les mois_annee avec emprunts_mensuels pour avoir tous les mois
    SELECT 
        ma.premier_jour_mois AS mois,
        g.genre,
        COALESCE(em.nombre_emprunts, 0) AS nombre_emprunts
    FROM 
        mois_annee ma
        CROSS JOIN (SELECT DISTINCT genre FROM livre) g
        LEFT JOIN emprunts_mensuels em ON ma.premier_jour_mois = em.mois AND g.genre = em.genre
)
SELECT 
    TO_CHAR(mois, 'YYYY-MM') AS mois,
    genre,
    nombre_emprunts,
    SUM(nombre_emprunts) OVER (PARTITION BY genre ORDER BY mois) AS emprunts_cumules,
    AVG(nombre_emprunts) OVER (PARTITION BY genre ORDER BY mois ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moyenne_mobile_3mois
FROM 
    stats_completes
ORDER BY 
    mois, genre;



--Quelles sont les tendances mensuelles
WITH adherent_genres AS (
    -- Genres empruntés par chaque adhérent
    SELECT 
        e.id_adh,
        l.genre,
        COUNT(*) AS nombre_emprunts,
        RANK() OVER (PARTITION BY e.id_adh ORDER BY COUNT(*) DESC) AS rang_genre
    FROM 
        emprunt e
        JOIN exemplaire ex ON e.id_livre = ex.id_livre
        JOIN livre l ON ex.isbn = l.isbn
    GROUP BY 
        e.id_adh, l.genre
),
adherent_auteurs AS (
    -- Auteurs empruntés par chaque adhérent
    SELECT 
        e.id_adh,
        l.id_auteur,
        COUNT(*) AS nombre_emprunts,
        RANK() OVER (PARTITION BY e.id_adh ORDER BY COUNT(*) DESC) AS rang_auteur
    FROM 
        emprunt e
        JOIN exemplaire ex ON e.id_livre = ex.id_livre
        JOIN livre l ON ex.isbn = l.isbn
    GROUP BY 
        e.id_adh, l.id_auteur
),
livres_empruntes AS (
    -- Livres déjà empruntés par chaque adhérent
    SELECT DISTINCT
        e.id_adh,
        l.id_livre
    FROM 
        emprunt e
        JOIN exemplaire ex ON e.id_livre = ex.id_livre
        JOIN livre l ON ex.isbn = l.isbn
),
recommandations AS (
    -- Génération des recommandations
    SELECT 
        a.id_adh,
        a.nom,
        a.prenom,
        l.id_livre,
        l.titre,
        l.genre,
        aut.nom AS nom_auteur,
        aut.prenom AS prenom_auteur,
        CASE 
            WHEN ag.rang_genre = 1 THEN 3
            WHEN ag.rang_genre = 2 THEN 2
            WHEN ag.rang_genre = 3 THEN 1
            ELSE 0
        END +
        CASE 
            WHEN aa.rang_auteur = 1 THEN 2
            WHEN aa.rang_auteur = 2 THEN 1
            ELSE 0
        END AS score_recommandation
    FROM 
        adherent a
        CROSS JOIN livre l
        JOIN auteur aut ON l.id_auteur = aut.id_auteur
        LEFT JOIN adherent_genres ag ON a.id_adh = ag.id_adh AND l.genre = ag.genre
        LEFT JOIN adherent_auteurs aa ON a.id_adh = aa.id_adh AND l.id_auteur = aa.id_auteur
        LEFT JOIN livres_empruntes le ON a.id_adh = le.id_adh AND l.id_livre = le.id_livre
    WHERE 
        le.id_livre IS NULL -- Exclure les livres déjà empruntés
        AND (ag.id_adh IS NOT NULL OR aa.id_adh IS NOT NULL) -- Inclure seulement si genre ou auteur correspond
)
SELECT 
    id_adh,
    nom,
    prenom,
    STRING_AGG(titre || ' (' || genre || ', ' || nom_auteur || ' ' || prenom_auteur || ')', ', ' ORDER BY score_recommandation DESC, titre) AS recommandations
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY id_adh ORDER BY score_recommandation DESC, titre) AS rn
    FROM 
        recommandations
    WHERE 
        score_recommandation > 0
) ranked
WHERE 
    rn <= 5  -- Limiter à 5 recommandations par adherent
GROUP BY 
    id_adh, nom, prenom
ORDER BY 
    nom, prenom;



--Quelle est l'état des commandes actuelles:
WITH commande_info AS (
    SELECT 
        c.id_commande,
        c.statut,
        c.date_commande,
        a.id_adh,
        a.nom AS nom_adherent,
        a.prenom AS prenom_adherent,
        l.id_livre,
        l.titre,
        l.genre,
        aut.nom AS nom_auteur,
        aut.prenom AS prenom_auteur,
        COALESCE(ex.nombre_exemplaires, 0) AS exemplaires_existants,
        COALESCE(emp.exemplaires_empruntes, 0) AS exemplaires_empruntes
    FROM 
        commande c
        JOIN adherent a ON c.id_adh = a.id_adh
        JOIN livre l ON c.isbn = l.isbn
        JOIN auteur aut ON l.id_auteur = aut.id_auteur
        LEFT JOIN (
            SELECT isbn, COUNT(*) AS nombre_exemplaires 
            FROM exemplaire 
            GROUP BY isbn
        ) ex ON l.isbn = ex.isbn
        LEFT JOIN (
            SELECT ex.isbn, COUNT(*) AS exemplaires_empruntes 
            FROM emprunt e 
            JOIN exemplaire ex ON e.id_livre = ex.id_livre 
            WHERE e.date_retour > CURRENT_DATE 
            GROUP BY ex.isbn
        ) emp ON l.isbn = emp.isbn
)
SELECT 
    id_commande,
    statut,
    date_commande,
    nom_adherent || ' ' || prenom_adherent AS adherent,
    titre,
    genre,
    nom_auteur || ' ' || prenom_auteur AS auteur,
    exemplaires_existants,
    exemplaires_empruntes,
    (exemplaires_existants - exemplaires_empruntes) AS exemplaires_disponibles,
    CASE 
        WHEN exemplaires_existants - exemplaires_empruntes > 0 THEN 'Disponible'
        ELSE 'Non disponible'
    END AS disponibilite,
    CASE 
        WHEN statut = 'en attente' AND exemplaires_existants - exemplaires_empruntes > 0 THEN 'Prêt à honorer'
        WHEN statut = 'en attente' THEN 'En attente d''exemplaire'
        ELSE statut
    END AS statut_detaille
FROM 
    commande_info
ORDER BY 
    CASE 
        WHEN statut = 'en attente' AND exemplaires_existants - exemplaires_empruntes > 0 THEN 1
        WHEN statut = 'en attente' THEN 2
        WHEN statut = 'honorée' THEN 3
        ELSE 4
    END,
    date_commande;



--Donner des recommendations pour tous les users:
WITH genre_stats AS (
    SELECT 
        l.genre,
        CASE 
            WHEN DATE_PART('year', e.date_emprunt) - 2000 < 10 THEN 'Décennie 2000'
            WHEN DATE_PART('year', e.date_emprunt) - 2010 < 10 THEN 'Décennie 2010'
            WHEN DATE_PART('year', e.date_emprunt) - 2020 < 10 THEN 'Décennie 2020'
            ELSE 'Autres'
        END AS periode,
        COUNT(*) AS nombre_emprunts
    FROM 
        emprunt e
        JOIN exemplaire ex ON e.id_livre = ex.id_livre
        JOIN livre l ON ex.isbn = l.isbn
    GROUP BY 
        l.genre, periode
)
SELECT 
    genre,
    periode,
    nombre_emprunts,
    ROUND(100.0 * nombre_emprunts / SUM(nombre_emprunts) OVER (PARTITION BY periode), 2) AS pourcentage_periode,
    RANK() OVER (PARTITION BY periode ORDER BY nombre_emprunts DESC) AS rang_dans_periode
FROM 
    genre_stats
ORDER BY 
    periode, nombre_emprunts DESC;