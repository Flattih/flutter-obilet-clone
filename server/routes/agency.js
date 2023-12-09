const router = require('express').Router();
const verifyToken = require('../middleware/verify_token');
const agencyController = require('../controller/agency_controller');






// Create a new agency
router.post('/create',agencyController.createAgency);



module.exports = router;

