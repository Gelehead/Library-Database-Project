/**
 * Service for handling database operations through the API
 */

// Choose the appropriate API URL based on environment
const API_URL = process.env.NODE_ENV === 'production'
  ? 'https://library-2935/api'  // Replace with your actual production URL
  : 'http://localhost:5000/api';

const databaseService = {
  /**
   * Fetches the result of a specific query
   * @param {number} queryNumber - The query number (1-4)
   * @returns {Promise<Array>} The query results
   */
  fetchQueryResult: async (queryNumber) => {
    if (queryNumber < 1 || queryNumber > 4) {
      throw new Error('Invalid query number. Must be between 1 and 4.');
    }

    try {
      const response = await fetch(`${API_URL}/query${queryNumber}`);
      
      if (!response.ok) {
        throw new Error(`HTTP error: ${response.status}`);
      }
      
      const result = await response.json();
      
      if (!result.success) {
        throw new Error(result.message || 'Unknown error occurred');
      }
      
      return result.data;
    } catch (error) {
      console.error(`Error fetching query ${queryNumber}:`, error);
      throw error;
    }
  },

  /**
   * Returns a description for each query
   */
  getQueryDescriptions: () => {
    return [
      {
        id: 1,
        title: "Livres empruntés par un adhérent",
        description: "Liste tous les livres empruntés par l'adhérent #1"
      },
      {
        id: 2,
        title: "Popularité par genre",
        description: "Affiche les genres de livres les plus populaires"
      },
      {
        id: 3,
        title: "Auteurs et leurs livres",
        description: "Liste tous les auteurs avec le nombre de livres qu'ils ont écrits"
      },
      {
        id: 4,
        title: "Commandes en attente",
        description: "Affiche les livres commandés mais pas encore empruntés"
      }
    ];
  }
};

export default databaseService;