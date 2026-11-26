var database = require("../database/config");

function autenticar(email, senha) {
    var instrucaoSql = `
        SELECT id_usuario AS id, nome, email, cpf FROM Usuario
        WHERE email = '${email}' AND senha_hash = SHA1('${senha}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(nome, cpf, email, senha) {
    var instrucaoSql = `
        INSERT INTO Usuario (nome, cpf, email, senha_hash, dt_cadastro)
        VALUES ('${nome}', '${cpf}', '${email}', SHA1('${senha}'), CURDATE());
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};