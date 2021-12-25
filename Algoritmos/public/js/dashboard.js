var horario = []
var qtd = []



function getGraph2() {
    var ax_data_horario = [];
    var ax_data_pessoas = [];
    let id_condominio = sessionStorage.ID_CONDOMINIO;
    let dia = document.getElementById('data_grafico').value
    dia = dia.replace(/\s/g, '');
    if (!dia) {
        alert("selecione uma data")
        return
    }
    fetch(`http://localhost:3333/usuarios/pegarHorario/${id_condominio}, ${dia}`)
        .then(
            function (resposta) {
                if (resposta.ok) {
                    resposta.json().then(json => {
                        for (let i = 0; i < json.length; i++) {
                            ax_data_horario.push(`${json[i].horario}hrs`)
                            ax_data_pessoas.push(json[i].pessoas)
                        }
                        myChartMovimentacao.data.labels = ax_data_horario
                        myChartMovimentacao.data.datasets[0].data = ax_data_pessoas
                        myChartMovimentacao.update();
                    })

                }

            }
        ).catch(function (erro) {
            console.log(erro)
        })
}

function getGraph1() {
    var ax_data_dias = [];
    var ax_data_pessoas = [];
    let id_condominio = sessionStorage.ID_CONDOMINIO;
    fetch(`http://localhost:3333/usuarios/pegarDias/${id_condominio}`)
        .then(
            function (resposta) {
                if (resposta.ok) {
                    resposta.json().then(json => {
                        for (var i = 0; i < json.length; i++) {
                            ax_data_dias.push(json[i].horario)
                            ax_data_pessoas.push(json[i].pessoas)
                        }
                        myChartDias.data.labels = ax_data_dias
                        myChartDias.data.datasets[0].data = ax_data_pessoas
                        myChartDias.update();
                        var soma = 0;
                        for (let i = 0; i < ax_data_pessoas.length; i++) {
                            soma += ax_data_pessoas[i]
                        }
                        var div = document.querySelector('.result_container')
                        ax_data_pessoas = []
                        ax_data_dias = []
                        for (let i = 0; i < json.length; i++) {
                            ax_data_dias.push(json[i].horario)
                            ax_data_pessoas.push(json[i].pessoas)
                            var antes = ax_data_pessoas[i-1]
                            var depois = json[i].pessoas
                            var date = json[i].horario
                            if (i != 0) {
                                var porcent = depois/antes
                                if (porcent>=1) {
                                    porcent = ((porcent - 1) * 100).toFixed(2)
                                    console.log(div, date, depois, porcent)
                                    createResultTrue(div, date, depois, porcent)
                                } else {
                                    porcent = (porcent*100).toFixed(2)
                                    console.log(div, date, depois, porcent)
                                    createResultFalse(div, date, depois, porcent)
                                }
                            }else{
                                let porcent = 0
                                createResultTrue(div, date, depois, porcent)
                            }
                            
                        }
                    })

                }

            }
        ).catch(function (erro) {
            console.log(erro)
        })
}

function getTempoReal(){
    let id_condominio = sessionStorage.ID_CONDOMINIO;
    fetch(`./usuarios/tempoReal/${id_condominio}`)
        .then(function(resposta){
            resposta.json().then(json=>{
                let qtd_ax = 0;
                for (let i = 0; i < json.length; i++) {
                    qtd_ax += json[i].pessoas;
                }
                
                if (horario.length==10) {
                    horario.shift()
                }
                if (qtd.length==10) {
                    qtd.shift()
                }
                horario.push(json[0].horario);
                qtd.push(qtd_ax);

                myChartTempoReal.data.labels = horario
                myChartTempoReal.data.datasets[0].data = qtd
                myChartTempoReal.update();
            })
        })
}

getGraph1()

function createResultTrue(div, date, number, porcent) {

    var result = document.createElement('div');
    result.className = 'result'
    var date_result = document.createElement('span');
    date_result.className = 'date_result'
    var number_result = document.createElement('span');
    number_result.className = 'number_result'

    var msg_result = document.createElement('div');
    msg_result.className = 'msg_result'
    var arrow = new Image(20, 20)
    var msg = document.createElement('p');
    msg_result.appendChild(arrow)
    msg_result.appendChild(msg)

    date_result.append(date)
    number_result.append(number)

    result.appendChild(date_result)
    result.appendChild(number_result)
    result.appendChild(msg_result)

    arrow.src = './assets/icon/arrowup.png'
    msg.innerHTML = `Aumentou ${porcent}%`

    if (number>200) {
        number_result.style.color = "rgba(153, 251, 49, 0.6)"
    } else if(number >150){
        number_result.style.color = "#ffc22299"
    } else if(number >100){
        number_result.style.color = "rgba(255, 131, 15, 0.6)"
    } else if (number > 0) {
        number_result.style.color = "rgba(255, 44, 33, 0.6)"
    }

    div.appendChild(result)
}

function createResultFalse(div, date, number, porcent) {

    var result = document.createElement('div');
    result.className = 'result'
    var date_result = document.createElement('span');
    date_result.className = 'date_result'
    var number_result = document.createElement('span');
    number_result.className = 'number_result'

    var msg_result = document.createElement('div');
    msg_result.className = 'msg_result'
    var arrow = new Image(20, 20)
    var msg = document.createElement('p');
    msg_result.appendChild(arrow)
    msg_result.appendChild(msg)

    date_result.append(date)
    number_result.append(number)

    result.appendChild(date_result)
    result.appendChild(number_result)
    result.appendChild(msg_result)

    if (number>200) {
        number_result.style.color = "rgba(153, 251, 49, 0.6)"
    } else if(number >150){
        number_result.style.color = "#ffc22299"
    } else if(number >100){
        number_result.style.color = "rgba(255, 131, 15, 0.6)"
    } else if (number > 0) {
        number_result.style.color = "rgba(255, 44, 33, 0.6)"
    }

        arrow.src = './assets/icon/arrowdown.png'
        msg.innerHTML = `Diminuiu ${porcent}%`

    div.appendChild(result)
}




setInterval(() => {
    getTempoReal();
}, 10000);