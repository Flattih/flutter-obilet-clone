const admin = require("firebase-admin");

const verifyToken = async (req, res, next) => {
  const idToken = req.headers.authorization;
  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const { email, uid } = decodedToken;
    req.email = email;
    req.uid = uid;
    next();
  } catch (error) {
    return res.status(500).json({ message: error.message, status: false });
  }
};

module.exports = verifyToken;
