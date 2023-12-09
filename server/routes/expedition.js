const router = require('express').Router();
const expeditionController = require('../controller/expedition_controller');
const verifyToken = require('../middleware/verify_token');





// Create a new expedition
router.post('/create',expeditionController.createExpedition);

// Get expeditions by date 
router.get('/getByDate/:date/:from/:to',expeditionController.getExpeditionsByDate);

// Get expeditions by user id
router.get('/getByUserId',verifyToken,expeditionController.getExpeditionsByUserId);

// Get expedition by id
router.get('/getById/:id',expeditionController.getExpeditionById);

// Reserve a seat
router.post('/reserveSeat',verifyToken,expeditionController.reserveSeat);





module.exports = router;

