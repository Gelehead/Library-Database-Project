// src/App.js
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
  const [activeQuery, setActiveQuery] = useState(null);
  const [queryDescriptions, setQueryDescriptions] = useState([]);

  // Add your team members' names here
  const teamMembers = [
    'Nom du membre 1',
    'Nom du membre 2',
    'Nom du membre 3',
    'Nom du membre 4'
  ];

  // Load query descriptions on component mount
  useEffect(() => {
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
      setError(err.message);
      setQueryData([]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="App">
      <Navbar />
      <div className="container">
        <h1>Bibliothèque - Projet IFT2935</h1>
        <div className="query-buttons">
          {queryDescriptions.map(query => (
            <QueryButton
              key={query.id}
              queryNumber={query.id}
              onClick={() => handleQueryClick(query.id)}
              title={query.title}
              description={query.description}
            />
          ))}
        </div>
        
        {activeQuery && (
          <div className="query-result-container">
            <h2>Résultat de la requête {activeQuery}</h2>
            {loading ? (
              <p>Chargement en cours...</p>
            ) : error ? (
              <p className="error">Erreur: {error}</p>
            ) : (
              <QueryResult data={queryData} queryNumber={activeQuery} />
            )}
          </div>
        )}
      </div>
      <Footer teamMembers={teamMembers} />
    </div>
  );
}

export default App;