var database = require("../database/config");

function autenticar(email, senha) {
    var instrucaoSql = `
        SELECT id_usuario AS id, nome, email, cpf FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(nome, cpf, email, senha) {
    var instrucaoSql = `
        INSERT INTO usuario (nome, cpf, email, senha, dt_cadastro)
        VALUES ('${nome}', '${cpf}', '${email}', '${senha}', CURDATE());
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};