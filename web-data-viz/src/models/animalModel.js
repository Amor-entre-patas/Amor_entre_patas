var database = require("../database/config");

function listar() {
    var instrucaoSql = `
        SELECT a.id_animal AS id, a.nome, a.especie, a.dt_nasc,
               o.nome AS ong, o.email AS contato
        FROM Animal a
        JOIN Ong o ON a.fk_ong = o.id_ong;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = { listar };