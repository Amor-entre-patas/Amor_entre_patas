var express = require("express");
var router = express.Router();

var animalController = require("../controllers/animalController");

router.get("/listar", function (req, res) {
    animalController.listar(req, res);
});

module.exports = router;