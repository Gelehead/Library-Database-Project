const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME ,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT || 5432,
});

console.log('Password type:', typeof process.env.DB_PASSWORD);
console.log('Password value:', process.env.DB_PASSWORD ? '[REDACTED]' : undefined);

pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error connecting to the database', err);
  } else {
    console.log('Database connected successfully at', res.rows[0].now);
  }
});

module.exports = {
  query: (text, params) => pool.query(text, params)
};