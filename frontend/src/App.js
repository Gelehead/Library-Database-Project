// src/App.js
import React, { useState } from 'react';
import './App.css';
import Navbar from './components/Navbar';
import QueryButton from './components/QueryButton';
import QueryResult from './components/QueryResult';
import Footer from './components/Footer';

function App() {
  const [queryData, setQueryData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [activeQuery, setActiveQuery] = useState(null);

  const teamMembers = [
    'Meriem Ghaoui',
    'Mohamed Thameur Sassi',
    'Mariam Traore',
    'Oscar Lavolet'
  ];

  const handleQueryClick = async (queryNumber) => {
    setLoading(true);
    setError(null);
    setActiveQuery(queryNumber);
    
    try {
      const response = await fetch(`http://localhost:5000/api/query${queryNumber}`);
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status}`);
      }
      
      const data = await response.json();
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
          <QueryButton queryNumber={1} onClick={() => handleQueryClick(1)} 
            description="Liste des livres empruntés par un adhérent spécifique" />
          <QueryButton queryNumber={2} onClick={() => handleQueryClick(2)} 
            description="Livres les plus populaires par genre" />
          <QueryButton queryNumber={3} onClick={() => handleQueryClick(3)} 
            description="Adhérents avec des retards" />
          <QueryButton queryNumber={4} onClick={() => handleQueryClick(4)} 
            description="Livres commandés mais pas encore empruntés" />
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