// src/components/QueryButton.jsx
import React from 'react';

const QueryButton = ({ queryNumber, onClick, description }) => {
  return (
    <button className="query-button" onClick={onClick}>
      <span className="query-number">Requête {queryNumber}</span>
      <span className="query-description">{description}</span>
    </button>
  );
};

export default QueryButton;