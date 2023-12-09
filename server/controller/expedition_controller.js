const Expedition = require("../models/expedition");
const mongoose = require("mongoose");

module.exports = {
  createExpedition: async (req, res) => {
    const {
      estimatedArrival,
      departureTime,
      departurePlace,
      destinationPlace,
      price,
      agencyId,
    } = req.body;
    const departureTimeDate = new Date(departureTime);
    departureTimeDate.setUTCHours(departureTimeDate.getUTCHours() + 3);
    try {
      const expedition = await Expedition.create({
        estimatedArrival,
        departureTime: departureTimeDate,
        departurePlace,
        destinationPlace,
        price,
        agency: agencyId,
      });
      return res.status(200).json(expedition);
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },
  getExpeditionsByDate: async (req, res) => {
    const date = req.params.date;
    const currentTime = new Date().toLocaleTimeString("tr-TR", {
      hour12: false,
      hour: "2-digit",
      minute: "2-digit",
      second: "2-digit",
    });
    const combinedDateTime = date + " " + currentTime;
    const turkishDate = new Date(combinedDateTime);
    turkishDate.setUTCHours(turkishDate.getUTCHours() + 3);
    const from = req.params.from;
    const to = req.params.to;

    try {
      let expeditions;
      const now = new Date();
      now.setUTCHours(now.getUTCHours() + 3);
      const ltDate = new Date(
        Date.UTC(
          turkishDate.getUTCFullYear(),
          turkishDate.getUTCMonth(),
          turkishDate.getUTCDate(),
          23,
          59,
          59,
          999
        )
      );
      if (
        turkishDate.getDate() === now.getDate() &&
        turkishDate.getMonth() === now.getMonth() &&
        turkishDate.getFullYear() === now.getFullYear()
      ) {
        console.log("Today");
        expeditions = await Expedition.find({
          departurePlace: from,
          destinationPlace: to,
          departureTime: {
            $gte: turkishDate,
            $lt: ltDate,
          },
        }).populate("agency");
      } else {
        console.log("Not today");
        expeditions = await Expedition.find({
          departurePlace: from,
          destinationPlace: to,
          departureTime: {
            $gte: new Date(
              Date.UTC(
                turkishDate.getUTCFullYear(),
                turkishDate.getUTCMonth(),
                turkishDate.getUTCDate(),
                0,
                0,
                0,
                0
              )
            ),
            $lt: ltDate,
          },
        }).populate("agency");
      }
      return res.status(200).json(expeditions);
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },

  reserveSeat: async (req, res) => {
    const { selectedSeatMap, expeditionId } = req.body;
    try {
      const expedition = await Expedition.findById(expeditionId);
      if (!expedition) {
        return res
          .status(404)
          .json({ message: "Expedition not found", status: false });
      }

      const selectedSeatNumbers = Object.keys(selectedSeatMap);
      const selectedGenders = Object.values(selectedSeatMap);
      const availableSeats = expedition.busSeatNumbers.filter(
        (seat) =>
          selectedSeatNumbers.includes(seat.number.toString()) &&
          seat.isAvailable
      );
      if (availableSeats.length !== selectedSeatNumbers.length) {
        return res
          .status(400)
          .json({ message: "Seat not available", status: false });
      }

      selectedSeatNumbers.forEach((seatNumber) => {
        const seat = expedition.busSeatNumbers.find(
          (seat) => seat.number.toString() === seatNumber
        );
        seat.gender = selectedSeatMap[seatNumber];
        seat.isAvailable = false;
        seat.userId = req.uid;
      });

      await expedition.save();
      return res.status(200).json({ message: "Seat reserved", status: true });
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },
  getExpeditionById: async (req, res) => {
    const expeditionId = req.params.id;
    try {
      const expedition = await Expedition.findById(expeditionId).populate(
        "agency"
      );
      if (!expedition) {
        return res
          .status(404)
          .json({ message: "Expedition not found", status: false });
      }
      return res.status(200).json(expedition);
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },

  getExpeditionsByUserId: async (req, res) => {
    const userId = req.uid;
    try {
      const expeditions = await Expedition.find({
        "busSeatNumbers.userId": userId,
      })
        .populate("agency")
        .sort({ departureTime: -1 });
      return res.status(200).json(expeditions);
    } catch (error) {
      return res.status(500).json({ message: error.message, status: false });
    }
  },
};
