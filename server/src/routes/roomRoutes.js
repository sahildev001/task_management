const express = require("express");
const auth = require("../middlewares/auth");

const { createRoom } = require("../controllers/roomControllers").default;

const roomRouter = express.Router();

roomRouter.post("/create", auth, createRoom);

module.exports = roomRouter;
