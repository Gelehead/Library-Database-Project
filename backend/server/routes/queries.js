/**
 * API routes for queries
 */
const express = require('express');
const router = express.Router();
const queryController = require('../controllers/queryController');

// Define routes for each query
router.get('/query1', queryController.executeQuery1);
router.get('/query2', queryController.executeQuery2);
router.get('/query3', queryController.executeQuery3);
router.get('/query4', queryController.executeQuery4);

module.exports = router;