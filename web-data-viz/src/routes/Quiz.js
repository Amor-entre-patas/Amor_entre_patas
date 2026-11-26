var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizController");

router.get("/perguntas", function (req, res) {
    quizController.listarPerguntas(req, res);
});

module.exports = router;