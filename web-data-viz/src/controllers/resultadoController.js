var resultadoModel = require("../models/resultadoModel");

function buscarResultado(req, res) {
    var idUsuario = req.params.idUsuario;

    resultadoModel.buscarResultado(idUsuario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function cadastrar(req, res) {
    var idUsuario = req.body.idUsuario;
    var respostas = req.body.respostas;

    if (idUsuario == undefined) {
        res.status(400).send("O idUsuario está undefined!");
    } else if (respostas == undefined || respostas.length == 0) {
        res.status(400).send("As respostas estão undefined!");
    } else {
        var lista = [];
        for (var i = 0; i < respostas.length; i++) {
            lista.push(Number(respostas[i]));
        }

        resultadoModel.cadastrar(Number(idUsuario), lista.join(",")).then(function (resultado) {
            res.status(201).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

module.exports = { buscarResultado, cadastrar };