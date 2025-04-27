import React from 'react';

const Footer = ({ teamMembers }) => {
  const currentYear = new Date().getFullYear();
  
  return (
    <footer className="footer">
      <div className="footer-content">
        <div className="footer-section">
          <h3>Projet Bibliothèque IFT2935</h3>
          <p>Système de gestion de bibliothèque développé dans le cadre du cours IFT2935.</p>
        </div>
        
        <div className="footer-section">
          <h3>Équipe</h3>
          <ul className="team-list">
            {teamMembers.map((member, index) => (
              <li key={index}>{member}</li>
            ))}
          </ul>
        </div>
        
        <div className="footer-section">
          <h3>Technologies</h3>
          <ul className="tech-list">
            <li>React</li>
            <li>Node.js / Express</li>
            <li>PostgreSQL</li>
          </ul>
        </div>
      </div>
      
      <div className="footer-bottom">
        <p>&copy; {currentYear} IFT2935 - Amogus sus </p>
      </div>
    </footer>
  );
};

export default Footer;