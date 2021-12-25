var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

router.get("/", function (req, res) {
    usuarioController.testar(req, res);
});

router.get("/listar", function (req, res) {
    usuarioController.listar(req, res);
});

router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrarCond", function (req, res) {
    usuarioController.cadastrarCond(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.entrar(req, res);
});

router.post("/mostrarCondominio", function (req, res) {
    usuarioController.mostrarCondominio(req, res);
});

router.get("/pegarHorario/:idCondominio,:dia", function (req, res) {
    usuarioController.pegarHorario(req, res);
});

router.get("/pegarDias/:idCondominio", function (req, res) {
    usuarioController.pegarDias(req, res);
});

router.get("/tempoReal/:idCondominio", function (req, res) {
    usuarioController.tempoReal(req, res);
});

module.exports = router;