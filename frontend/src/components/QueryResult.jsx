import React, { useState } from 'react';

const QueryResult = ({ data, queryNumber }) => {
  const [sortConfig, setSortConfig] = useState({ key: null, direction: 'ascending' });
  const [searchTerm, setSearchTerm] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const rowsPerPage = 10;
  
  if (!data || data.length === 0) {
    return <p>Aucun résultat trouvé pour cette requête.</p>;
  }

  const columns = Object.keys(data[0]);

  const requestSort = (key) => {
    let direction = 'ascending';
    if (sortConfig.key === key && sortConfig.direction === 'ascending') {
      direction = 'descending';
    }
    setSortConfig({ key, direction });
  };

  const sortedData = [...data].sort((a, b) => {
    if (sortConfig.key) {
      const aValue = a[sortConfig.key];
      const bValue = b[sortConfig.key];
      
      // Handle different types of values
      if (aValue === null || aValue === undefined) return 1;
      if (bValue === null || bValue === undefined) return -1;
      
      const aNum = !isNaN(parseFloat(aValue)) ? parseFloat(aValue) : null;
      const bNum = !isNaN(parseFloat(bValue)) ? parseFloat(bValue) : null;
      
      if (aNum !== null && bNum !== null) {
        return sortConfig.direction === 'ascending' ? aNum - bNum : bNum - aNum;
      }
      
      const aDate = new Date(aValue);
      const bDate = new Date(bValue);
      if (!isNaN(aDate) && !isNaN(bDate)) {
        return sortConfig.direction === 'ascending' 
          ? aDate.getTime() - bDate.getTime() 
          : bDate.getTime() - aDate.getTime();
      }
      
      if (typeof aValue === 'string' && typeof bValue === 'string') {
        return sortConfig.direction === 'ascending'
          ? aValue.localeCompare(bValue)
          : bValue.localeCompare(aValue);
      }
    }
    return 0;
  });
  
  const filteredData = sortedData.filter(row => {
    if (!searchTerm.trim()) return true;
    
    return Object.values(row).some(value => {
      if (value === null || value === undefined) return false;
      return String(value).toLowerCase().includes(searchTerm.toLowerCase());
    });
  });
  
  const totalPages = Math.ceil(filteredData.length / rowsPerPage);
  const startIndex = (currentPage - 1) * rowsPerPage;
  const paginatedData = filteredData.slice(startIndex, startIndex + rowsPerPage);
  
  const formatValue = (value) => {
    if (value === null || value === undefined) return '-';
    
    if (value instanceof Date && !isNaN(value)) {
      return value.toLocaleDateString();
    }
    
    const dateObj = new Date(value);
    if (typeof value === 'string' && 
        value.match(/^\d{4}-\d{2}-\d{2}/) && 
        !isNaN(dateObj)) {
      return dateObj.toLocaleDateString();
    }
    
    if (typeof value === 'string' && value.length > 100) {
      return (
        <div className="truncated-text">
          {value.slice(0, 100)}...
          <span className="full-text-tooltip">{value}</span>
        </div>
      );
    }
    
    return String(value);
  };
  
  const getSortIndicator = (column) => {
    if (sortConfig.key !== column) return 'sort-indicator';
    return sortConfig.direction === 'ascending' 
      ? 'sort-indicator ascending' 
      : 'sort-indicator descending';
  };

  return (
    <div className="query-result">
      <div className="query-controls">
        <div className="search-container">
          <input
            type="text"
            placeholder="Rechercher..."
            value={searchTerm}
            onChange={(e) => {
              setSearchTerm(e.target.value);
              setCurrentPage(1);
            }}
            className="search-input"
          />
        </div>
        
        <div className="result-count">
          {filteredData.length} résultat(s) trouvé(s)
        </div>
      </div>
      
      <div className="table-container">
        <table>
          <thead>
            <tr>
              {columns.map((column, index) => (
                <th 
                  key={index} 
                  onClick={() => requestSort(column)}
                  className={getSortIndicator(column)}
                >
                  {formatColumnName(column)}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {paginatedData.map((row, rowIndex) => (
              <tr key={rowIndex}>
                {columns.map((column, colIndex) => (
                  <td key={colIndex}>{formatValue(row[column])}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      
      {totalPages > 1 && (
        <div className="pagination">
          <button 
            onClick={() => setCurrentPage(1)} 
            disabled={currentPage === 1}
            className="pagination-button"
          >
            «
          </button>
          <button 
            onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))} 
            disabled={currentPage === 1}
            className="pagination-button"
          >
            ‹
          </button>
          
          <span className="pagination-info">
            Page {currentPage} sur {totalPages}
          </span>
          
          <button 
            onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))} 
            disabled={currentPage === totalPages}
            className="pagination-button"
          >
            ›
          </button>
          <button 
            onClick={() => setCurrentPage(totalPages)} 
            disabled={currentPage === totalPages}
            className="pagination-button"
          >
            »
          </button>
        </div>
      )}
    </div>
  );
};

const formatColumnName = (columnName) => {
  return columnName
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
};

export default QueryResult;