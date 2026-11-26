var database = require("../database/config");


function listarPerguntas() {
    var instrucaoSql = `
        SELECT q.id_quiz, q.pergunta,
               a.id_alternativa_letra AS id_alternativa, a.texto_alternativa
        FROM Quiz q
        JOIN Alternativa a ON a.fk_quiz = q.id_quiz
        ORDER BY q.id_quiz, a.id_alternativa_letra;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = { listarPerguntas };