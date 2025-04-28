# Bibliothèque - Projet IFT2935

Application web pour le projet final du cours IFT2935 - Base de données.

Cette application permet de visualiser les résultats de 4 requêtes SQL spécifiques via une interface graphique simple.

## Structure du projet

- **Frontend**: Application React
- **Backend**: Serveur Express avec PostgreSQL
- **Base de données**: Schéma normalisé selon les instructions du projet

### Prérequis

- Node.js (v14 ou plus récent)
- npm (v6 ou plus récent)
- PostgreSQL (v12 ou plus récent)

### Installation

1. Clonez le dépôt:
   ```
   git clone https://github.com/Gelehead/Library-Database-Project.git
   cd Library-Database-Project
   ```

2. Installez les dépendances:
   Vous devrez faire cela dans le repertoire backend et frontend
   ```
   npm install
   cd backend
   npm install
   cd ..
   cd frontend
   npm install 
   cd ..
   ```

3. Configurez la base de données:
   - Créez une base de données PostgreSQL nommée `bibliotheque`
      - Si vous ne voulez pas l appeler ainsi, changer le nom
   - Exécutez le script SQL fourni dans le fichier `projetdb.sql` pour créer les tables et insérer les données

4. Configurez les paramètres de connexion à la base de données:
   - Modifiez le fichier `backend/server/config/db.js` avec vos informations de connexion (utilisateur, mot de passe, nom de la base de données, hôte.)
   - Changer là ou il y a écrit `Modifier_ici`

### Démarrage de l'application

Pour démarrer l'application en mode développement:

```
npm run dev
```

Cette commande lancera simultanément le serveur backend et le frontend.

### Utilisation

1. Ouvrez votre navigateur à l'adresse [http://localhost:3000](http://localhost:3000)
2. Cliquez sur l'un des quatre boutons de requête pour afficher les résultats correspondants

### Fonctionnalités

L'application affiche les résultats des 4 requêtes SQL définies dans le fichier `backend/server/utils/queryHelper.js`:

1. **Requête 10**: Recommendations personnalisées pour chacun des utilisateurs.

   Concept
   - on propose de nouveaux livres à lire basés sur ses genres et auteurs préférés, en leur attribuant un score.

   - Plus un livre correspond à son genre préféré ou à un auteur qu’il aime, plus son score est élevé.
   
   Nous avons utilisé
   - Des jointures multiples (⋈) entre adherent, emprunt, exemplaire, livre, et auteur
   - Des projections (π) pour les colonnes sélectionnées
   - De la sélection (σ) pour filtrer les conditions comme les livres empruntés ou pas
   - L'Aggrégation (γ) pour grouper et compter 
   - Des opérations d'ensemble pour créer des recommendations personnalisées

   Optimisation
   - Découpe en CTEs pour mieux structurer
   - Utilisation de RANK() pour éviter des recalculs lourds
   - DISTINCT pour éviter des doublons inutiles
   - LEFT JOIN pour garder tous les adhérents même si certains n'ont pas tous les éléments
   - Utilisation de ROW_NUMBER() pour choisir les 5 meilleurs résultats facilement
   
2. **Requête 9**: Statut détaillé des commandes

   On détaille 
   - Qui a commandé quoi
   - Combien d’exemplaires existent
   - Combien sont déjà empruntés
   - Le nombre d’exemplaires encore disponibles.
   - Le statut de la commande

   Algèbre relationnel
   - Jointures (⋈) avec adhérent, livre, auteur
   - Sous-requêtes pour compter les exemplaires existants et empruntés
   - Projection (π) avec de nouveaux champs calculés
   - Sélection (σ) basée sur la date actuelle pour savoir si un livre est encore emprunté
   - Tri avec logique sur le statut

   Optimisation
   - CTE pour rendre la logique plus lisible
   - COALESCE pour remplacer les valeurs NULL (ex : zéro exemplaires si aucun trouvé)
   - LEFT JOIN pour inclure toutes les commandes même sans livre associé
   - Calculs faits en une seule passe pour éviter de multiples calculs
   - CASE pour gérer des statuts conditionnels facilement
   - Filtres temporels (CURRENT_DATE) pour rester à jour
   
3. **Requête 11**: Analyse des tendances mensuelles

   Concept : 
   - On génère une liste de tous les mois entre le premier et dernier emprunt
   - On compte combien de livres ont été empruntés chaque mois par genre
   - Pour les mois où rien n’a été emprunté, on crée une ligne avec 0
   - On calcule ensuite le total cumulé d’emprunts pour chaque genre.
   - Finalement, on fait une moyenne mobile sur 3 mois pour lisser les tendances

   Algèbre relationnel
   - Génération de séries temporelles avec generate_series
   - Jointures (⋈) entre emprunt, exemplaire et livre
   - Agrégation (γ) pour compter les emprunts mensuels
   - Produit cartésien (×) pour s’assurer que chaque mois/genre est représenté
   - Projection (π) pour sortir les bonnes colonnes

   Optimisation
   - Utilisation de generate_series pour générer les dates efficacement
   - DATE_TRUNC pour aligner les dates au début du mois
   - CTEs pour structurer proprement
   - LEFT JOIN pour remplir les mois sans emprunts
   - Utilisation de window functions pour cumuler et lisser les données
   - COALESCE pour éviter les NULL (mettre 0 emprunts)


4. **Requête 6**: Tendance par décennie

   Concept
   - pour chaque emprunt, on classe la date dans une décennie (2000s, 2010s, etc.), puis on compte combien de livres de chaque genre ont été empruntés.

   - On calcule le pourcentage de chaque genre par rapport au total de sa décennie.
   - On classe les genres du plus populaire au moins populaire.

   Algèbre relationnel
   - Jointures (⋈) entre emprunt, exemplaire et livre
   - Projection (π) pour générer une nouvelle colonne de période (décennie)
   - Agrégation (γ) pour compter les emprunts par genre et décennie
   - Calculs statistiques avancés (pourcentages)

   Optimisation
   - CTE pour clarifier la logique
   - Génération d’une variable catégorielle periode (décennie) directement en SQL
   - Calcul du SUM OVER pour obtenir les pourcentages sans repasser plusieurs fois
   - RANK() pour classer les genres facilement
   - Utilisation efficace de DATE_PART pour manipuler les dates
   - ROUND pour arrondir joliment les résultats
   - Tri des résultats pour lecture facile (par décennie et popularité)

Notez que le numéro des requêtes ne sont pas cohérents, c est parce que plusieures autres requêtes ont été créées et nous avons juste choisi les plus intéressantes

### Technologies utilisées

- **Frontend**: React, CSS
- **Backend**: Node.js, Express
- **Base de données**: SQL

### Auteurs

- Meriem Ghaoui
- Mohamed Thameur Sassi
- Mariam Traore
- Oscar Lavolet

### Remise:
-Fichier SQL: ProjetBD_questions.sql
-Normalisation: Normalisation.projet.pdf
-Model Entité association et relationnel: EA_relationel.pdf