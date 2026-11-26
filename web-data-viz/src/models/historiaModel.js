var database = require("../database/config");

// A pessoa digita o e-mail no site: cria o status "Em analise".
// Depois você conversa com ela, e a história entra na tabela Historias.
function solicitar(idUsuario, email) {
    var instrucaoSql = `
        INSERT INTO Statuss (email, atualmente, fk_usuario)
        VALUES (?, 'Em analise', ${idUsuario});
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [email]);
}

// Grava a história já escrita (status + texto)
function cadastrar(idUsuario, historia) {
    var sqlStatus = `
        INSERT INTO Statuss (email, atualmente, fk_usuario)
        SELECT email, 'Em analise', id_usuario FROM Usuario
        WHERE id_usuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + sqlStatus);

    return database.executar(sqlStatus).then(function (status) {
        var sqlHistoria = `
            INSERT INTO Historias (historia, fk_statuss, fk_usuario)
            VALUES (?, ${status.insertId}, ${idUsuario});
        `;
        console.log("Executando a instrução SQL: \n" + sqlHistoria);
        return database.executar(sqlHistoria, [historia]);
    });
}

// só mostra as histórias aprovadas
function listarAprovadas() {
    var instrucaoSql = `
        SELECT u.nome, h.historia
        FROM Historias h
        JOIN Statuss s ON h.fk_statuss = s.id_statuss
        JOIN Usuario u ON h.fk_usuario = u.id_usuario
        WHERE s.atualmente = 'Aprovado';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = { solicitar, cadastrar, listarAprovadas };