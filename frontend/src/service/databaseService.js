const API_URL = process.env.NODE_ENV === 'production'
  ? 'https://library-2935/api' 
  : 'http://localhost:5000/api';

const databaseService = {

  testConnection: async () => {
    try {
      const response = await fetch(`${API_URL}/test`);
      if (response.ok) {
        const data = await response.json();
        console.log('API test successful:', data);
        return true;
      }
      return false;
    } catch (error) {
      console.error('API test failed:', error);
      return false;
    }
  },

  fetchQueryResult: async (queryNumber) => {
    if (queryNumber < 1 || queryNumber > 11) {
      throw new Error('Invalid query number. Must be between 1 and 11.');
    }

    const url = `${API_URL}/query${queryNumber}`;
    console.log(`Fetching data from: ${url}`);

    try {
      const response = await fetch(url);
      
      if (!response.ok) {
        console.error(`HTTP error ${response.status} from ${url}`);
        throw new Error(`HTTP error: ${response.status}`);
      }
      
      const result = await response.json();
      console.log(`Query ${queryNumber} result structure:`, 
        Object.keys(result).length > 0 ? Object.keys(result) : 'empty response');
      
      if (result.success && Array.isArray(result.data)) {
        return result.data;
      } else if (Array.isArray(result)) {
        return result;
      } else {
        console.warn('Unexpected response format:', result);
        return [];
      }
    } catch (error) {
      console.error(`Error fetching query ${queryNumber}:`, error);
      throw error;
    }
  },

  getQueryDescriptions: () => {
    return [
/*       {
        id: 1,
        title: "Livres empruntés",
        description: "Liste tous les livres empruntés par l'adhérent #1"
      },
      {
        id: 2,
        title: "Genres populaires",
        description: "Affiche les genres de livres les plus populaires"
      },
      {
        id: 3,
        title: "Auteurs",
        description: "Liste tous les auteurs avec le nombre de livres qu'ils ont écrits"
      },
      {
        id: 4,
        title: "Commandes en attente",
        description: "Affiche les livres commandés mais pas encore empruntés"
      },
      {
        id: 5,
        title: "Profil adhérents",
        description: "Statistiques des emprunts par adhérent avec leurs livres récents"
      }, */
      {
        id: 6,
        title: "Tendances par période",
        description: "Analyse des tendances de genres par décennie"
      },
/*       {
        id: 7,
        title: "Statistiques auteurs",
        description: "Performance des auteurs par ratio d'emprunts"
      },
      {
        id: 8,
        title: "Durée par genre",
        description: "Durée moyenne d'emprunt et taux de retard par genre"
      }, */
      {
        id: 9,
        title: "État des commandes",
        description: "Analyse détaillée des commandes et leur disponibilité"
      },
      {
        id: 10,
        title: "Recommandations",
        description: "Suggestions personnalisées pour chaque adhérent"
      },
      {
        id: 11,
        title: "Évolution mensuelle",
        description: "Tendances mensuelles des emprunts par genre"
      }
    ];
  }
};

export default databaseService;