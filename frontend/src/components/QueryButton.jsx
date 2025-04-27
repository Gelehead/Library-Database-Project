import React from 'react';

const QueryButton = ({ queryNumber, onClick, title, description }) => {
  return (
    <tr className="query-row" onClick={onClick}>
      <td className="query-number">{queryNumber}</td>
      <td className="query-title">{title}</td>
      <td className="query-description">{description}</td>
      <td className="query-action">
        <button className="execute-button">Exécuter</button>
      </td>
    </tr>
  );
};

export default QueryButton;