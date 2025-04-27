const { Pool, Client } = require('pg');
require('dotenv').config();

const pool = new Pool({
  user: Modifier_ici,
  host: Modifier_ici,
  database: Modifier_ici ,
  password: Modifier_ici,
  port: 5432,
});

pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error executing query', err);  // More specific error logging
    return;
  }
  console.log('Database connected successfully at', res.rows[0].now);
});
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