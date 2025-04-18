# Bibliothèque - Projet IFT2935

Application web pour le projet final du cours IFT2935 - Base de données.

Cette application permet de visualiser les résultats de 4 requêtes SQL spécifiques via une interface graphique simple.

## Structure du projet

- **Frontend**: Application React
- **Backend**: Serveur Express avec PostgreSQL
- **Base de données**: Schéma normalisé selon les instructions du projet

## Prérequis

- Node.js (v14 ou plus récent)
- npm (v6 ou plus récent)
- PostgreSQL (v12 ou plus récent)

## Installation

1. Clonez le dépôt:
   ```
   git clone <URL-du-dépôt>
   cd bibliotheque-app
   ```

2. Installez les dépendances:
   ```
   npm install
   ```

3. Configurez la base de données:
   - Créez une base de données PostgreSQL nommée `bibliotheque`
   - Exécutez le script SQL fourni dans le fichier `setup.sql` pour créer les tables et insérer les données

4. Configurez les paramètres de connexion à la base de données:
   - Modifiez le fichier `server/server.js` avec vos informations de connexion (utilisateur, mot de passe, etc.)

## Démarrage de l'application

Pour démarrer l'application en mode développement:

```
npm run dev
```

Cette commande lancera simultanément le serveur backend (sur le port 5000) et le frontend (sur le port 3000).

## Utilisation

1. Ouvrez votre navigateur à l'adresse [http://localhost:3000](http://localhost:3000)
2. Cliquez sur l'un des quatre boutons de requête pour afficher les résultats correspondants

## Fonctionnalités

L'application affiche les résultats des 4 requêtes SQL définies dans le fichier `server/queries.js`:

1. **Requête 1**: Liste des livres empruntés par un adhérent spécifique
2. **Requête 2**: Livres les plus populaires par genre
3. **Requête 3**: Adhérents avec des retards de retour
4. **Requête 4**: Livres commandés mais pas encore empruntés

## Technologies utilisées

- **Frontend**: React, CSS
- **Backend**: Node.js, Express
- **Base de données**: PostgreSQL

## Auteurs

- [Votre nom]
- [Noms des membres du groupe]

## Licence

Ce projet est réalisé dans le cadre du cours IFT2935 - Base de données à l'Université de Montréal.