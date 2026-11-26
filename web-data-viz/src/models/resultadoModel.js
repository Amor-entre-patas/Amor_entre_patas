var database = require("../database/config");

function buscarResultado(idUsuario) {
    var instrucaoSql = `
        SELECT
            c.nome_categoria AS categoria,
            p.pontuacao_obtida AS pontuacao,
            c.pontuacao_maxima AS maxima,
            (SELECT ROUND(AVG(p2.pontuacao_obtida), 1)
             FROM Pontuacao p2
             WHERE p2.fk_categoria = c.id_categoria) AS media
        FROM Pontuacao p
        JOIN Categoria c ON p.fk_categoria = c.id_categoria
        WHERE p.fk_resultado_quiz = (
            SELECT MAX(id_resultado_quiz) FROM Resultado_quiz
            WHERE fk_usuario = ${idUsuario}
        )
        ORDER BY c.id_categoria;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(idUsuario, listaAlternativas) {
    var sqlResultado = `
        INSERT INTO Resultado_quiz (dt_realizacao, fk_usuario)
        VALUES (CURDATE(), ${idUsuario});
    `;

    return database.executar(sqlResultado).then(function (inserido) {
        var idResultado = inserido.insertId;

        var sqlPontuacao = `
            INSERT INTO Pontuacao (fk_resultado_quiz, fk_categoria, pontuacao_obtida)
            SELECT ${idResultado}, q.fk_categoria, SUM(a.pontuacao_alternativa)
            FROM Alternativa a
            JOIN Quiz q ON a.fk_quiz = q.id_quiz
            WHERE a.id_alternativa_letra IN (${listaAlternativas})
            GROUP BY q.fk_categoria;
        `;

        return database.executar(sqlPontuacao).then(function () {
            var sqlClassificacao = `
                UPDATE Resultado_quiz SET classificacao = (
                    SELECT CASE
                        WHEN SUM(pontuacao_obtida) >= 80 THEN 'Pronto para adotar'
                        WHEN SUM(pontuacao_obtida) >= 50 THEN 'Quase pronto'
                        ELSE 'Ainda não está pronto'
                    END
                    FROM Pontuacao WHERE fk_resultado_quiz = ${idResultado}
                ) WHERE id_resultado_quiz = ${idResultado};
            `;
            return database.executar(sqlClassificacao);
        });
    });
}

module.exports = { buscarResultado, cadastrar };