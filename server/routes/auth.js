const router = require('express').Router();
const authController = require('../controller/auth_controller');
const verifyToken = require('../middleware/verify_token');





router.post('/signin',authController.signIn);

router.get('/get-user',verifyToken,authController.getUser);

module.exports = router;