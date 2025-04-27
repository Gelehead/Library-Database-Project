import React, { useState, useEffect } from 'react';
import './App.css';
import Navbar from './components/Navbar';
import QueryButton from './components/QueryButton';
import QueryResult from './components/QueryResult';
import Footer from './components/Footer';
import databaseService from './service/databaseService';

function App() {
  const [queryData, setQueryData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [apiStatus, setApiStatus] = useState({ tested: false, connected: false });
  const [activeQuery, setActiveQuery] = useState(null);
  const [queryDescriptions, setQueryDescriptions] = useState([]);

  const teamMembers = [
    'Nom du membre 1',
    'Nom du membre 2',
    'Nom du membre 3',
    'Nom du membre 4'
  ];

  useEffect(() => {
    const testConnection = async () => {
      try {
        const connected = await databaseService.testConnection();
        setApiStatus({ tested: true, connected });
      } catch (err) {
        console.error('Error testing API connection:', err);
        setApiStatus({ tested: true, connected: false });
      }
    };

    testConnection();
    setQueryDescriptions(databaseService.getQueryDescriptions());
  }, []);

  const handleQueryClick = async (queryNumber) => {
    setLoading(true);
    setError(null);
    setActiveQuery(queryNumber);
    
    try {
      const data = await databaseService.fetchQueryResult(queryNumber);
      setQueryData(data);
    } catch (err) {
      console.error(`Error in query ${queryNumber}:`, err);
      setError(err.message || 'An unknown error occurred');
      setQueryData([]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="App">
      <Navbar />
      <main className="container">
        <h1>Projet IFT2935 - Système de Gestion de Bibliothèque</h1>
        
        {apiStatus.tested && !apiStatus.connected && (
          <div className="api-error-message">
            <h2>Erreur de connexion à l'API</h2>
            <p>Impossible de se connecter au serveur API. Veuillez vérifier que:</p>
            <ul>
              <li>Le serveur est en cours d'exécution sur le port 5000</li>
              <li>Les requêtes CORS sont autorisées</li>
              <li>Le chemin d'API est correct (http://localhost:5000/api)</li>
            </ul>
            <button 
              onClick={() => window.location.reload()} 
              className="retry-button"
            >
              Réessayer
            </button>
          </div>
        )}
        
        {(!apiStatus.tested || apiStatus.connected) && (
          <>
            <div className="queries-section">
              <h2>Requêtes disponibles</h2>
              <div className="queries-table-container">
                <table className="queries-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Titre</th>
                      <th>Description</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {queryDescriptions.map(query => (
                      <QueryButton
                        key={query.id}
                        queryNumber={query.id}
                        onClick={() => handleQueryClick(query.id)}
                        title={query.title}
                        description={query.description}
                      />
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
            
            {activeQuery && (
              <div className="query-result-container">
                <h2>Résultat de la requête {activeQuery}: {queryDescriptions.find(q => q.id === activeQuery)?.title}</h2>
                {loading ? (
                  <div className="loading-container">
                    <div className="loading-spinner"></div>
                    <p>Chargement en cours...</p>
                  </div>
                ) : error ? (
                  <div className="error-container">
                    <p className="error">Erreur: {error}</p>
                    <p>Vérifiez que le serveur est en cours d'exécution et que les requêtes sont correctement configurées.</p>
                  </div>
                ) : (
                  <QueryResult data={queryData} queryNumber={activeQuery} />
                )}
              </div>
            )}
          </>
        )}
      </main>
      <Footer teamMembers={teamMembers} />
    </div>
  );
}

export default App;