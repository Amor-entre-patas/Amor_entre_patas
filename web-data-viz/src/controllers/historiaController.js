var historiaModel = require("../models/historiaModel");

function solicitar(req, res) {
    var idUsuario = Number(req.body.idUsuario);
    var email = req.body.email;

    if (isNaN(idUsuario)) {
        res.status(400).send("idUsuario inválido!");
    } else if (email == undefined || email.indexOf("@") == -1 || email.length > 45) {
        res.status(400).send("E-mail inválido!");
    } else {
        historiaModel.solicitar(idUsuario, email).then(function (resultado) {
            res.status(201).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

function cadastrar(req, res) {
    var idUsuario = Number(req.body.idUsuario);
    var historia = req.body.historia;

    if (isNaN(idUsuario)) {
        res.status(400).send("idUsuario inválido!");
    } else if (historia == undefined || historia.length == 0) {
        res.status(400).send("A história está vazia!");
    } else if (historia.length > 7000) {
        res.status(400).send("A história passou de 7000 caracteres!");
    } else {
        historiaModel.cadastrar(idUsuario, historia).then(function (resultado) {
            res.status(201).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

function listarAprovadas(req, res) {
    historiaModel.listarAprovadas().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhuma história aprovada!");
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = { solicitar, cadastrar, listarAprovadas };