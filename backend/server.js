/**
 * Main server file for the Bibliothèque backend
 */
const express = require('express');
const cors = require('cors');
require('dotenv').config();
const queryRoutes = require('./server/routes/queries');

// Initialize express app
const app = express();
const PORT = process.env.PORT || 5000;

// Apply middleware
app.use(cors());
app.use(express.json());

// Log all requests
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// API routes
app.use('/api', queryRoutes);

// Health check endpoint
app.get('/', (req, res) => {
  res.json({
    status: 'API is running',
    message: 'Welcome to the Bibliothèque API',
    endpoints: {
      queries: '/api/query1, /api/query2, /api/query3, /api/query4'
    }
  });
});

// Handle 404 errors
app.use((req, res) => {
  res.status(404).json({
    status: 'error',
    message: 'Endpoint not found'
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`API available at http://localhost:${PORT}`);
});