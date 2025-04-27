# Bibliothèque - Projet IFT2935

Application web pour le projet final du cours IFT2935 - Base de données.

Cette application permet de visualiser les résultats de 4 requêtes SQL spécifiques via une interface graphique simple.

## Structure du projet

- **Frontend**: Application React
- **Backend**: Serveur Express avec PostgreSQL
- **Base de données**: Schéma normalisé selon les instructions du projet

## Différentes façons de consulter le travail

1. Consulter la github page [ici](https://gelehead.github.io/Library-Database-Project/)

2. suivre les étapes d'installation local qui suivent

### Prérequis

- Node.js (v14 ou plus récent)
- npm (v6 ou plus récent)
- PostgreSQL (v12 ou plus récent)

### Installation

1. Clonez le dépôt:
   ```
   git clone https://github.com/Gelehead/Library-Database-Project.git
   cd Library-Database-P
   ```

2. Installez les dépendances:
   ```
   npm install
   ```

3. Créer un fichier `.env` avec les informations suivantes
      ```
      PORT=5000
      DB_USER=postgres
      DB_PASSWORD=your_password
      DB_HOST=localhost
      DB_NAME=bibliotheque
      DB_PORT=5432
      ```
   - modifier "your_password" par votre mot de passe

3. Configurez la base de données:
   - Créez une base de données PostgreSQL nommée `bibliotheque`
   - Exécutez le script SQL fourni dans le fichier `projetdb.sql` pour créer les tables et insérer les données

4. Configurez les paramètres de connexion à la base de données:
   - Modifiez le fichier `server/server.js` avec vos informations de connexion (utilisateur, mot de passe, etc.)

### Démarrage de l'application

Pour démarrer l'application en mode développement:

```
npm run dev
```

Cette commande lancera simultanément le serveur backend (sur le port 5000) et le frontend (sur le port 3000).

### Utilisation

1. Ouvrez votre navigateur à l'adresse [http://localhost:3000](http://localhost:3000)
2. Cliquez sur l'un des quatre boutons de requête pour afficher les résultats correspondants

### Fonctionnalités

L'application affiche les résultats des 4 requêtes SQL définies dans le fichier `server/queries.js`:

1. **Requête 1**: aaa
2. **Requête 2**: aaa
3. **Requête 3**: aaa
4. **Requête 4**: aaa

### Technologies utilisées

- **Frontend**: React, CSS
- **Backend**: Node.js, Express
- **Base de données**: SQL

### Auteurs

- Meriem Ghaoui
- Mohamed Thameur Sassi
- Mariam Traore
- Oscar Lavolet