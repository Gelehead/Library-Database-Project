/**
 * Controller for database queries
 */
const db = require('../config/db');
const queries = require('../utils/queryHelper');

// Controller methods for each query
exports.executeQuery1 = async (req, res) => {
  try {
    const result = await db.query(queries.query1);
    res.json({
      success: true,
      data: result.rows,
      message: 'Query executed successfully'
    });
  } catch (error) {
    console.error('Error executing query 1:', error);
    res.status(500).json({
      success: false,
      message: 'Error executing query',
      error: error.message
    });
  }
};

exports.executeQuery2 = async (req, res) => {
  try {
    const result = await db.query(queries.query2);
    res.json({
      success: true,
      data: result.rows,
      message: 'Query executed successfully'
    });
  } catch (error) {
    console.error('Error executing query 2:', error);
    res.status(500).json({
      success: false,
      message: 'Error executing query',
      error: error.message
    });
  }
};

exports.executeQuery3 = async (req, res) => {
  try {
    const result = await db.query(queries.query3);
    res.json({
      success: true,
      data: result.rows,
      message: 'Query executed successfully'
    });
  } catch (error) {
    console.error('Error executing query 3:', error);
    res.status(500).json({
      success: false,
      message: 'Error executing query',
      error: error.message
    });
  }
};

exports.executeQuery4 = async (req, res) => {
  try {
    const result = await db.query(queries.query4);
    res.json({
      success: true,
      data: result.rows,
      message: 'Query executed successfully'
    });
  } catch (error) {
    console.error('Error executing query 4:', error);
    res.status(500).json({
      success: false,
      message: 'Error executing query',
      error: error.message
    });
  }
};