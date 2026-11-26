var quizModel = require("../models/quizModel");

function listarPerguntas(req, res) {
    quizModel.listarPerguntas().then(function (linhas) {
        if (linhas.length == 0) {
            res.status(204).send("Nenhuma pergunta encontrada!");
        } else {
            // junta as linhas: cada pergunta com a sua lista de alternativas
            var perguntas = [];

            for (var i = 0; i < linhas.length; i++) {
                var ultima = perguntas[perguntas.length - 1];

                if (ultima == undefined || ultima.id != linhas[i].id_quiz) {
                    perguntas.push({
                        id: linhas[i].id_quiz,
                        pergunta: linhas[i].pergunta,
                        alternativas: []
                    });
                    ultima = perguntas[perguntas.length - 1];
                }

                ultima.alternativas.push({
                    id: linhas[i].id_alternativa,
                    texto: linhas[i].texto_alternativa
                });
            }

            res.status(200).json(perguntas);
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = { listarPerguntas };