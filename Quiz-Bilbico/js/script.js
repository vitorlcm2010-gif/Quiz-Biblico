
let perguntas = [];
let perguntaAtual = 0;
let pontos = 0;
let respostaSelecionada = null;
let respondida = false;

let numeroPergunta = document.getElementById("numeroPergunta");
let pontuacao = document.getElementById("pontuacao");
let pergunta = document.getElementById("pergunta");
let alternativas = document.getElementById("alternativas");
let feedback = document.getElementById("feedback");
let btnResponder = document.getElementById("btnResponder");
let btnProxima = document.getElementById("btnProxima");
let barraProgresso = document.getElementById("barraProgresso");
let quiz = document.getElementById("quiz");
let resultado = document.getElementById("resultado");
let pontuacaoFinal = document.getElementById("pontuacaoFinal");
let btnReiniciar = document.getElementById("btnReiniciar");

async function buscarPerguntas() {
    try {
        pergunta.textContent = "Carregando perguntas...";
        btnResponder.disabled = true;

        let resposta = await fetch("http://127.0.0.1:5000/perguntas");

        if (!resposta.ok) {
            throw new Error("Erro ao buscar perguntas");
        }

        let dados = await resposta.json();

        perguntas = dados.map(function (item) {
            return {
                pergunta: item.enunciado,
                alternativas: [
                    item.alternativa_a,
                    item.alternativa_b,
                    item.alternativa_c,
                    item.alternativa_d
                ],
                correta: ["A", "B", "C", "D"].indexOf(item.resposta_correta)
            };
        });

        if (perguntas.length === 0) {
            pergunta.textContent = "Nenhuma pergunta cadastrada.";
            return;
        }

        carregarPergunta();

    } catch (erro) {
        pergunta.textContent = "Erro ao carregar perguntas. Verifique se o Flask está ligado.";
        console.error(erro);
    }
}

function carregarPergunta() {
    respostaSelecionada = null;
    respondida = false;

    feedback.textContent = "";
    btnResponder.disabled = true;
    btnResponder.hidden = false;
    btnProxima.hidden = true;

    numeroPergunta.textContent =
        "Pergunta " + (perguntaAtual + 1) + " de " + perguntas.length;

    pontuacao.textContent = "Pontos: " + pontos;

    pergunta.textContent = perguntas[perguntaAtual].pergunta;

    barraProgresso.style.width =
        ((perguntaAtual + 1) / perguntas.length) * 100 + "%";

    alternativas.textContent = "";

    perguntas[perguntaAtual].alternativas.forEach(function (texto, indice) {
        let botao = document.createElement("button");

        botao.textContent = String.fromCharCode(65 + indice) + ") " + texto;
        botao.classList.add("alternativa");

        botao.addEventListener("click", function () {
            if (respondida) {
                return;
            }

            let botoes = document.querySelectorAll(".alternativa");

            botoes.forEach(function (item) {
                item.classList.remove("selecionada");
            });

            botao.classList.add("selecionada");

            respostaSelecionada = indice;
            btnResponder.disabled = false;
        });

        alternativas.appendChild(botao);
    });
}

btnResponder.addEventListener("click", function () {
    if (respostaSelecionada === null || respondida) {
        return;
    }

    respondida = true;

    let respostaCorreta = perguntas[perguntaAtual].correta;
    let botoes = document.querySelectorAll(".alternativa");

    botoes.forEach(function (botao, indice) {
        botao.disabled = true;

        if (indice === respostaCorreta) {
            botao.classList.add("correta");
        }

        if (indice === respostaSelecionada && indice !== respostaCorreta) {
            botao.classList.add("errada");
        }
    });

    if (respostaSelecionada === respostaCorreta) {
        pontos++;
        feedback.textContent = "Parabéns! Você acertou!";
        feedback.style.color = "#24864b";
    } else {
        feedback.textContent = "Resposta incorreta! Tente na próxima.";
        feedback.style.color = "#c0392b";
    }

    pontuacao.textContent = "Pontos: " + pontos;

    btnResponder.hidden = true;
    btnProxima.hidden = false;
});

btnProxima.addEventListener("click", function () {
    perguntaAtual++;

    if (perguntaAtual < perguntas.length) {
        carregarPergunta();
    } else {
        finalizarQuiz();
    }
});


async function finalizarQuiz() {
    quiz.hidden = true;
    resultado.hidden = false;

    pontuacaoFinal.textContent =
        "Você acertou " + pontos + " de " + perguntas.length + " perguntas!";

    try {
        let resposta = await fetch("http://127.0.0.1:5000/partidas", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                pontuacao: pontos,
                total_acertos: pontos,
                id_categoria: 1
            })
        });

        if (!resposta.ok) {
            throw new Error("Erro ao salvar partida");
        }

        console.log("Partida salva com sucesso!");

    } catch (erro) {
        console.error(erro);
        pontuacaoFinal.textContent +=
            " Não foi possível salvar a pontuação.";
    }
}


btnReiniciar.addEventListener("click", function () {
    perguntaAtual = 0;
    pontos = 0;

    quiz.hidden = false;
    resultado.hidden = true;

    carregarPergunta();
});

buscarPerguntas();
