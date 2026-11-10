
from flask import Flask, jsonify, request
from dao import listar_perguntas, salvar_partida

app = Flask(__name__)


@app.route("/perguntas", methods=["GET"])
def perguntas():
    return jsonify(listar_perguntas())


@app.route("/partidas", methods=["POST"])
def criar_partida():
    dados = request.get_json(silent=True)

    if not dados:
        return jsonify({"erro": "Envie os dados da partida"}), 400

    try:
        pontuacao = int(dados["pontuacao"])
        total_acertos = int(dados["total_acertos"])
        id_categoria = int(dados["id_categoria"])
    except (KeyError, ValueError, TypeError):
        return jsonify({"erro": "Dados invalidos"}), 400

    if pontuacao < 0 or total_acertos < 0 or id_categoria < 1:
        return jsonify({"erro": "Valores invalidos"}), 400

    id_partida = salvar_partida(
        pontuacao,
        total_acertos,
        id_categoria
    )

    return jsonify({
        "mensagem": "Partida salva com sucesso!",
        "id_partida": id_partida
    }), 201


if __name__ == "__main__":
    app.run(debug=True)


