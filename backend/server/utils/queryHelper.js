/**
 * Query definitions for the library database
 * These are the example queries for your project
 * You should replace these with your chosen 4 queries from step 5
 */

// Query 1: List all books borrowed by a specific adherent
const query1 = `
SELECT e.id_emprunt, l.titre, l.genre, a.nom AS nom_auteur, a.prenom AS prenom_auteur, 
       e.date_emprunt, e.date_retour
FROM emprunt e
JOIN exemplaire ex ON e.id_livre = ex.id_livre
JOIN livre l ON ex.isbn = l.isbn
JOIN auteur a ON l.id_auteur = a.id_auteur
WHERE e.id_adh = 1
ORDER BY e.date_emprunt DESC;
`;

// Query 2: Popular books by genre (number of loans per genre)
const query2 = `
SELECT l.genre, COUNT(*) as nombre_emprunts
FROM emprunt e
JOIN exemplaire ex ON e.id_livre = ex.id_livre
JOIN livre l ON ex.isbn = l.isbn
GROUP BY l.genre
ORDER BY nombre_emprunts DESC;
`;

// Query 3: List of all authors with their book count
const query3 = `
SELECT a.id_auteur, a.nom, a.prenom, COUNT(l.id_livre) as nombre_livres
FROM auteur a
JOIN livre l ON a.id_auteur = l.id_auteur
GROUP BY a.id_auteur, a.nom, a.prenom
ORDER BY nombre_livres DESC;
`;

// Query 4: Books ordered but not yet borrowed
const query4 = `
SELECT c.id_commande, l.titre, l.genre, a.nom AS nom_auteur, a.prenom AS prenom_auteur,
       ad.nom AS nom_adherent, ad.prenom AS prenom_adherent, c.date_commande, c.statut
FROM commande c
JOIN livre l ON c.isbn = l.isbn
JOIN auteur a ON l.id_auteur = a.id_auteur
JOIN adherent ad ON c.id_adh = ad.id_adh
WHERE c.statut = 'en attente'
ORDER BY c.date_commande;
`;

module.exports = {
  query1,
  query2,
  query3,
  query4
};