const express = require('express');
const router = express.Router();
const queryController = require('../controllers/queryController');

router.get('/test', queryController.testConnection);

router.get('/query1', queryController.executeQuery1);
router.get('/query2', queryController.executeQuery2);
router.get('/query3', queryController.executeQuery3);
router.get('/query4', queryController.executeQuery4);
router.get('/query5', queryController.executeQuery5);
router.get('/query6', queryController.executeQuery6);
router.get('/query7', queryController.executeQuery7);
router.get('/query8', queryController.executeQuery8);
router.get('/query9', queryController.executeQuery9);
router.get('/query10', queryController.executeQuery10);
router.get('/query11', queryController.executeQuery11);

module.exports = router;