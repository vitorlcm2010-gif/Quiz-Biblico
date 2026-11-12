
import mysql.connector


def conectar():
    conexao = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="quiz_biblico"
    )

    return conexao


def listar_perguntas():
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    cursor.execute("SELECT * FROM perguntas")
    perguntas = cursor.fetchall()

    cursor.close()
    conexao.close()

    return perguntas


def salvar_partida(pontuacao, total_acertos, id_categoria):
    conexao = conectar()
    cursor = conexao.cursor()

    sql = """
    INSERT INTO partidas
    (pontuacao, total_acertos, id_categoria)
    VALUES (%s, %s, %s)
    """

    valores = (pontuacao, total_acertos, id_categoria)

    cursor.execute(sql, valores)
    conexao.commit()

    id_partida = cursor.lastrowid

    cursor.close()
    conexao.close()

    return id_partida
