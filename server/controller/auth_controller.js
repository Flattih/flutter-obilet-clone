const User = require("../models/user");
const admin = require("firebase-admin");

module.exports = {
  signIn: async (req, res) => {
    const { idToken, username, phone } = req.body;
    try {
      const decodedToken = await admin.auth().verifyIdToken(idToken);
      const { email, uid, name } = decodedToken;
      const user = await User.findOne({ email });
      if (user) {
        return res.status(200).json(user);
      } else {
        const newUser = new User(
          { email, uid, username: username || name, phone },
          { __v: 0 }
        );
        await newUser.save();
        return res.status(200).json(newUser);
      }
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },

  getUser: async (req, res) => {
    try {
      console.log(req.uid);
      const user = await User.findOne({ uid: req.uid });
      console.log(user);
      return res.status(200).json(user);
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },
};
