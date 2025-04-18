// src/services/databaseService.js

/**
 * Service for handling database operations through the API
 */
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
        const response = await fetch(`http://localhost:5000/api/query${queryNumber}`);
        
        if (!response.ok) {
          throw new Error(`HTTP error: ${response.status}`);
        }
        
        return await response.json();
      } catch (error) {
        console.error(`Error fetching query ${queryNumber}:`, error);
        throw error;
      }
    },
  };
  
  export default databaseService;