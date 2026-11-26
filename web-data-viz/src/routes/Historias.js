var express = require("express");
var router = express.Router();

var historiaController = require("../controllers/historiaController");

router.post("/solicitar", function (req, res) {
    historiaController.solicitar(req, res);
});

router.post("/cadastrar", function (req, res) {
    historiaController.cadastrar(req, res);
});

router.get("/listar", function (req, res) {
    historiaController.listarAprovadas(req, res);
});

module.exports = router;