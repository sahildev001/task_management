const express = require('express');
const auth = require('../middlewares/auth');

const {createBoard} = require('../controllers/boardControllers').default;


const boardRouter = express.Router();

boardRouter.post("/create", auth, createBoard);

module.exports = boardRouter;
