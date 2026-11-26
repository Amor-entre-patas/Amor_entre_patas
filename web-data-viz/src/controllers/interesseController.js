var interesseModel = require("../models/interesseModel");

function cadastrar(req, res) {
    var idAnimal = Number(req.body.idAnimal);
    var idUsuario = Number(req.body.idUsuario);

    if (isNaN(idAnimal) || isNaN(idUsuario)) {
        res.status(400).send("idAnimal ou idUsuario inválido!");
    } else {
        interesseModel.cadastrar(idAnimal, idUsuario).then(function (resultado) {
            res.status(201).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

function remover(req, res) {
    var idAnimal = Number(req.body.idAnimal);
    var idUsuario = Number(req.body.idUsuario);

    if (isNaN(idAnimal) || isNaN(idUsuario)) {
        res.status(400).send("idAnimal ou idUsuario inválido!");
    } else {
        interesseModel.remover(idAnimal, idUsuario).then(function (resultado) {
            res.status(200).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

function listarPorUsuario(req, res) {
    var idUsuario = Number(req.params.idUsuario);

    if (isNaN(idUsuario)) {
        res.status(400).send("idUsuario inválido!");
    } else {
        interesseModel.listarPorUsuario(idUsuario).then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum favorito encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

module.exports = { cadastrar, remover, listarPorUsuario };