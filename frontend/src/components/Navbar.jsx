import React from 'react';

const Navbar = () => {
  return (
    <nav className="navbar">
      <div className="navbar-container">
        <div className="navbar-logo">
          <span className="logo-text">Bibliotheque</span>
        </div>
        <div className="navbar-subtitle">
          Système de Gestion de Bibliothèque
        </div>
      </div>
    </nav>
  );
};

export default Navbar;