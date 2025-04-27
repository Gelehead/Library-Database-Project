const express = require('express');
const cors = require('cors');
require('dotenv').config();
const queryRoutes = require('./server/routes/queries');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

app.use('/api', queryRoutes);

app.get('/', (req, res) => {
  res.json({
    status: 'API is running',
    message: 'Welcome to the Bibliothèque API',
    endpoints: {
      test: '/api/test',
      queries: '/api/query1 through /api/query11'
    }
  });
});

app.use((req, res) => {
  console.log(`404 Not Found: ${req.method} ${req.originalUrl}`);
  res.status(404).json({
    status: 'error',
    message: 'Endpoint not found'
  });
});

app.use((err, req, res, next) => {
  console.error(`Error occurred: ${err.stack}`);
  res.status(500).json({
    status: 'error',
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'production' ? null : err.message
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`API available at http://localhost:${PORT}`);
  console.log(`API test endpoint: http://localhost:${PORT}/api/test`);
  console.log(`Supported queries: /api/query1 through /api/query11`);
});