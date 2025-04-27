const db = require('../config/db');
const queries = require('../utils/queryHelper');

const executeQuery = (queryNumber) => async (req, res) => {
  try {
    const result = await db.query(queries[`query${queryNumber}`]);
    res.json({
      success: true,
      data: result.rows,
      message: 'Query executed successfully'
    });
  } catch (error) {
    console.error(`Error executing query ${queryNumber}:`, error);
    res.status(500).json({
      success: false,
      message: 'Error executing query',
      error: error.message
    });
  }
};

exports.executeQuery1 = executeQuery(1);
exports.executeQuery2 = executeQuery(2);
exports.executeQuery3 = executeQuery(3);
exports.executeQuery4 = executeQuery(4);
exports.executeQuery5 = executeQuery(5);
exports.executeQuery6 = executeQuery(6);
exports.executeQuery7 = executeQuery(7);
exports.executeQuery8 = executeQuery(8);
exports.executeQuery9 = executeQuery(9);
exports.executeQuery10 = executeQuery(10);
exports.executeQuery11 = executeQuery(11);

exports.testConnection = (req, res) => {
  res.json({
    success: true,
    message: 'API connection successful',
    timestamp: new Date().toISOString()
  });
};