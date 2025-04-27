// server/queries.js

const query1 = `
  SELECT l.titre, l.genre, a.nom, a.prenom 
  FROM emprunt e
  JOIN exemplaire ex ON e.id_livre = ex.id_livre
  JOIN livre l ON ex.isbn = l.isbn
  JOIN auteur a ON l.id_auteur = a.id_auteur
  JOIN adherent ad ON e.id_adherent = ad.id_adh
  WHERE ad.id_adh = 1
  ORDER BY e.date_d_emprunt DESC;
`;

const query2 = `
  SELECT l.genre, COUNT(*) as nombre_emprunts
  FROM emprunt e
  JOIN exemplaire ex ON e.id_livre = ex.id_livre
  JOIN livre l ON ex.isbn = l.isbn
  GROUP BY l.genre
  ORDER BY nombre_emprunts DESC;
`;

const query3 = `
  SELECT ad.id_adh, ad.nom, ad.prenom, COUNT(*) as nombre_retards
  FROM emprunt e
  JOIN adherent ad ON e.id_adherent = ad.id_adh
  WHERE e.date_de_retour > (e.date_d_emprunt + INTERVAL '14 days')
  GROUP BY ad.id_adh, ad.nom, ad.prenom
  ORDER BY nombre_retards DESC;
`;

const query4 = `
  SELECT l.titre, l.genre, a.nom AS nom_auteur, a.prenom AS prenom_auteur, 
         ad.nom AS nom_adherent, ad.prenom AS prenom_adherent,
         c.date_commande
  FROM commande c
  JOIN livre l ON c.isbn = l.isbn
  JOIN auteur a ON l.id_auteur = a.id_auteur
  JOIN adherent ad ON c.id_adherent = ad.id_adh
  WHERE c.statut = 'en attente'
  ORDER BY c.date_commande;
`;

const query5 = `
SELECT 
    a.id_adh,
    a.nom,
    a.prenom,
    COUNT(e.id_emprunt) AS nombre_emprunts,
    STRING_AGG(l.titre, ', ' ORDER BY e.date_emprunt DESC) AS livres_recents,
    MAX(e.date_emprunt) AS dernier_emprunt
FROM 
    adherent a
    LEFT JOIN emprunt e ON a.id_adh = e.id_adh
    LEFT JOIN exemplaire ex ON e.id_livre = ex.id_livre
    LEFT JOIN livre l ON ex.isbn = l.isbn
GROUP BY 
    a.id_adh, a.nom, a.prenom
ORDER BY 
    nombre_emprunts DESC, dernier_emprunt DESC;
`;

const query6 = `
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
`;

const query7 = `
WITH auteur_stats AS (
    SELECT 
        a.id_auteur,
        a.nom,
        a.prenom,
        COUNT(DISTINCT l.id_livre) AS nombre_livres,
        COUNT(DISTINCT ex.id_livre) AS nombre_exemplaires,
        COUNT(DISTINCT e.id_emprunt) AS nombre_emprunts
    FROM 
        auteur a
        LEFT JOIN livre l ON a.id_auteur = l.id_auteur
        LEFT JOIN exemplaire ex ON l.isbn = ex.isbn
        LEFT JOIN emprunt e ON ex.id_livre = e.id_livre
    GROUP BY 
        a.id_auteur, a.nom, a.prenom
)
SELECT 
    id_auteur,
    nom,
    prenom,
    nombre_livres,
    nombre_exemplaires,
    nombre_emprunts,
    CASE 
        WHEN nombre_exemplaires = 0 THEN 0
        ELSE ROUND(nombre_emprunts::numeric / nombre_exemplaires, 2)
    END AS ratio_emprunt_exemplaire,
    CASE 
        WHEN nombre_livres = 0 THEN 0
        ELSE ROUND(nombre_emprunts::numeric / nombre_livres, 2)
    END AS ratio_emprunt_livre
FROM 
    auteur_stats
ORDER BY 
    ratio_emprunt_exemplaire DESC, nombre_emprunts DESC;
`;

const query8 = `
SELECT 
    l.genre,
    COUNT(e.id_emprunt) AS nombre_emprunts,
    ROUND(AVG(e.date_retour - e.date_emprunt), 1) AS duree_moyenne_jours,
    MIN(e.date_retour - e.date_emprunt) AS duree_min_jours,
    MAX(e.date_retour - e.date_emprunt) AS duree_max_jours,
    ROUND(STDDEV(e.date_retour - e.date_emprunt), 2) AS ecart_type_jours,
    COUNT(CASE WHEN e.date_retour > (e.date_emprunt + INTERVAL '14 days') THEN 1 END) AS nombre_retards,
    ROUND(COUNT(CASE WHEN e.date_retour > (e.date_emprunt + INTERVAL '14 days') THEN 1 END)::numeric / COUNT(*) * 100, 2) AS pourcentage_retards
FROM 
    emprunt e
    JOIN exemplaire ex ON e.id_livre = ex.id_livre
    JOIN livre l ON ex.isbn = l.isbn
GROUP BY 
    l.genre
ORDER BY 
    pourcentage_retards DESC, nombre_emprunts DESC;
`;

const query9 = `
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
`;

const query10 = `
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
`;

const query11 = `
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
`;

module.exports = {
  query1,
  query2,
  query3,
  query4,
  query5,
  query6,
  query7,
  query8,
  query9,
  query10,
  query11
};