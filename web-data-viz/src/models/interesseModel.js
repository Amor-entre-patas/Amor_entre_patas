var database = require("../database/config");

function cadastrar(idAnimal, idUsuario) {
    var instrucaoSql = `
        INSERT IGNORE INTO Interesse_adoacao (fk_animal, fk_usuario)
        VALUES (${idAnimal}, ${idUsuario});
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function remover(idAnimal, idUsuario) {
    var instrucaoSql = `
        DELETE FROM Interesse_adoacao
        WHERE fk_animal = ${idAnimal} AND fk_usuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarPorUsuario(idUsuario) {
    var instrucaoSql = `
        SELECT a.id_animal AS id, a.nome, a.especie,
               o.nome AS ong, o.email AS contato
        FROM Interesse_adoacao i
        JOIN Animal a ON i.fk_animal = a.id_animal
        JOIN Ong o ON a.fk_ong = o.id_ong
        WHERE i.fk_usuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = { cadastrar, remover, listarPorUsuario };