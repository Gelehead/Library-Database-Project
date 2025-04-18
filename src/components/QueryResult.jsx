// src/components/QueryResult.jsx
import React from 'react';

const QueryResult = ({ data, queryNumber }) => {
  if (!data || data.length === 0) {
    return <p>Aucun résultat trouvé pour cette requête.</p>;
  }

  // Get column names from the first result
  const columns = Object.keys(data[0]);

  return (
    <div className="query-result">
      <table>
        <thead>
          <tr>
            {columns.map((column, index) => (
              <th key={index}>{formatColumnName(column)}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {data.map((row, rowIndex) => (
            <tr key={rowIndex}>
              {columns.map((column, colIndex) => (
                <td key={colIndex}>{row[column]}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

// Helper function to format column names for display
const formatColumnName = (columnName) => {
  return columnName
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
};

export default QueryResult;