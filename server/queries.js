// server/queries.js

// Replace these queries with your actual queries from step 5
const query1 = `
  -- Example query 1: List all books borrowed by a specific adhérent
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
  -- Example query 2: Most popular books by genre
  SELECT l.genre, COUNT(*) as nombre_emprunts
  FROM emprunt e
  JOIN exemplaire ex ON e.id_livre = ex.id_livre
  JOIN livre l ON ex.isbn = l.isbn
  GROUP BY l.genre
  ORDER BY nombre_emprunts DESC;
`;

const query3 = `
  -- Example query 3: Adhérents with late returns
  SELECT ad.id_adh, ad.nom, ad.prenom, COUNT(*) as nombre_retards
  FROM emprunt e
  JOIN adherent ad ON e.id_adherent = ad.id_adh
  WHERE e.date_de_retour > (e.date_d_emprunt + INTERVAL '14 days')
  GROUP BY ad.id_adh, ad.nom, ad.prenom
  ORDER BY nombre_retards DESC;
`;

const query4 = `
  -- Example query 4: Books ordered but not yet borrowed
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

module.exports = {
  query1,
  query2,
  query3,
  query4
};