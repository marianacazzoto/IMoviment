var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {
    instrucaoSql = `select 
                        pessoas, 
                        horario,
                        DATE_FORMAT(horario,'%H:%i:%s') as momento_grafico
                    from registro
                    where id_condominio = ${idAquario}
                    order by id_condominio desc limit ${limite_linhas}`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {
    instrucaoSql = `select 
                        pessoa,  DATE_FORMAT(horario,'%H:%i:%s') as momento_grafico, 
                        id_condominio 
                        from registro where id_condominio = ${idAquario} 
                    order by id_condominio desc limit 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}