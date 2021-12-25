var usuarioModel = require("../models/usuarioModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS NA usuarioController");
    res.json("ESTAMOS FUNCIONANDO!");
}

function listar(req, res) {
    usuarioModel.listar()
        .then(function (resultado) {
            if (resultado.length > 0) {
                
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function mostrarCondominio(req, res){
    var usuario = req.body.usuario
    if (usuario == undefined) {
        res.status(400).send("Seu usuario está undefined!");
    } else {
        usuarioModel.mostrarCondominio(usuario)
            .then(function(resultado){
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!")
                }
            }).catch(function(erro){
                console.log(erro)
            })
    }
    
}

function entrar(req, res) {
    var email = req.body.email;
    var senha = req.body.senha;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {
        
        usuarioModel.entrar(email, senha)
            .then(
                function (resultado) {
                    if (resultado.length == 1) {
                        console.log(JSON.stringify(resultado))
                        res.json(resultado[0]);
                    } else if (resultado.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function pegarHorario(req, res){
    var condominio = req.params.idCondominio
    var dia = req.params.dia
    usuarioModel.pegarHorario(condominio, dia)
        .then(function(resposta){
            console.log("deu certo");
            if (resposta.length > 0) {
                res.status(200).json(resposta)
            } else if(resposta.length = 0){
                res.status(204).send("meu, ta vazio!")
            }
        }).catch(function(erro){
            console.log(erro)
        })
}

function pegarDias(req, res){
    var condominio = req.params.idCondominio
    usuarioModel.pegarDias(condominio)
        .then(function(resposta){
            console.log("deu certo");
            if (resposta.length > 0) {
                res.status(200).json(resposta)
            } else if(resposta.length = 0){
                res.status(204).send("meu, ta vazio!")
            }
        }).catch(function(erro){
            console.log(erro)
        })
}

function tempoReal(req,res){
    var condominio = req.params.idCondominio
    usuarioModel.tempoReal(condominio)
        .then(function(resposta){
            console.log("deu certo");
            if (resposta.length > 0) {
                res.status(200).json(resposta)
            } else if(resposta.length = 0){
                res.status(204).send("meu, ta vazio!")
            }
        }).catch(function(erro){
            console.log(erro)
        })
}

function cadastrar(req, res) {
    var razaoSocial = req.body.razaoSocial;
    var cnpj = req.body.cnpj;
    var telefone = req.body.telefone;
    var email = req.body.email;
    var senha = req.body.senha;

    if (razaoSocial == undefined) {
        res.status(400).send("Seu razaoSocial está undefined!");
    } else if (cnpj == undefined) {
        res.status(400).send("Seu cnpj está undefined!");
    }else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    }else if (telefone == undefined) {
        res.status(400).send("Seu telefone está undefined!");
    } else {
        
        usuarioModel.cadastrar(razaoSocial, cnpj, telefone, email, senha)
            .then(
                function () {
                    usuarioModel.entrar(email, senha)
                        .then(
                            function(resultado){
                                res.json(resultado[0]);
                            }
                        ).catch(
                            function (erro){
                                console.log(erro)
                                res.status(500).json(erro.sqlMessage);
                            }
                        )
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}


function cadastrarCond(req, res) {
    var nome = req.body.nome;
    var cep = req.body.cep;
    var num = req.body.num;
    var thumbnail = req.body.thumbnail;
    var usuario = req.body.usuario;

    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    }
    else if (cep == undefined) {
        res.status(400).send("Seu cep está undefined!");
    }
    else if (num == undefined) {
        res.status(400).send("Seu num está undefined!");
    }
    else if (thumbnail == undefined) {
        res.status(400).send("Seu telefone está undefined!");
    } else {
        usuarioModel.cadastrarCond(nome, cep, num, thumbnail , usuario)
            .then(
                function(resposta){
                    res.status(200).json(resposta)
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    entrar,
    cadastrarCond,
    cadastrar,
    listar,
    testar,
    mostrarCondominio,
    pegarHorario,
    pegarDias,
    tempoReal
}