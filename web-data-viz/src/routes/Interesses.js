var express = require("express");
var router = express.Router();

var interesseController = require("../controllers/interesseController");

router.post("/cadastrar", function (req, res) {
    interesseController.cadastrar(req, res);
});

router.post("/remover", function (req, res) {
    interesseController.remover(req, res);
});

router.get("/listar/:idUsuario", function (req, res) {
    interesseController.listarPorUsuario(req, res);
});

module.exports = router;