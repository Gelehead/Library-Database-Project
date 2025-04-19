// server/server.js
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const queries = require('./queries');

const app = express();
const port = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'bibliotheque',
  password: 'your_password', // Change this to your actual password
  port: 5432,
});

// Test the database connection
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error connecting to the database', err);
  } else {
    console.log('Database connected successfully');
  }
});

app.get('/api/query1', async (req, res) => {
  try {
    const result = await pool.query(queries.query1);
    res.json(result.rows);
  } catch (error) {
    console.error('Error executing query 1:', error);
    res.status(500).json({ error: 'An error occurred while executing query 1' });
  }
});

app.get('/api/query2', async (req, res) => {
  try {
    const result = await pool.query(queries.query2);
    res.json(result.rows);
  } catch (error) {
    console.error('Error executing query 2:', error);
    res.status(500).json({ error: 'An error occurred while executing query 2' });
  }
});

app.get('/api/query3', async (req, res) => {
  try {
    const result = await pool.query(queries.query3);
    res.json(result.rows);
  } catch (error) {
    console.error('Error executing query 3:', error);
    res.status(500).json({ error: 'An error occurred while executing query 3' });
  }
});

app.get('/api/query4', async (req, res) => {
  try {
    const result = await pool.query(queries.query4);
    res.json(result.rows);
  } catch (error) {
    console.error('Error executing query 4:', error);
    res.status(500).json({ error: 'An error occurred while executing query 4' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});