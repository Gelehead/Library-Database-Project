const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const queries = require('./queries');

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());


pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error connecting to the database', err);
  } else {
    console.log('Database connected successfully');
  }
});

const handleQuery = (queryNumber) => async (req, res) => {
  try {
    const result = await pool.query(queries[`query${queryNumber}`]);
    res.json({ data: result.rows });
  } catch (error) {
    console.error(`Error executing query ${queryNumber}:`, error);
    res.status(500).json({ 
      message: `An error occurred while executing query ${queryNumber}`,
      error: error.message
    });
  }
};

for (let i = 1; i <= 11; i++) {
  app.get(`/api/query${i}`, handleQuery(i));
}

app.get('/api/test', (req, res) => {
  res.json({ message: 'API is working!' });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
  console.log(`Test the API at: http://localhost:${port}/api/test`);
});