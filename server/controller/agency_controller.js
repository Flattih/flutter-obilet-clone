const Agency = require("../models/agency");

module.exports = {
  createAgency: async (req, res) => {
    const { name, logo } = req.body;
    try {
      const agency = await Agency.create({ name, logo });
      return res
        .status(200)
        .json({ message: "Agency created", status: true, data: agency });
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },
};
