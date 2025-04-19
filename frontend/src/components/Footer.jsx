// src/components/Footer.jsx
import React from 'react';

const Footer = ({ teamMembers }) => {
  return (
    <footer className="navbar footer">
      <div className="footer-brand">
        <span>IFT2935 - Projet Final • Hiver 2025</span>
      </div>
      <div className="team-info">
        <span className="team-label">Équipe:</span>
        <div className="team-members">
          {teamMembers.map((member, index) => (
            <span key={index} className="member-name">
              {member}
              {index < teamMembers.length - 1 && " • "}
            </span>
          ))}
        </div>
      </div>
    </footer>
  );
};

export default Footer;