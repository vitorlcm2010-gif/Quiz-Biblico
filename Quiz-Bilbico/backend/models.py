
class Categoria:
    def __init__(self, id_categoria, nome):
        self.id_categoria = id_categoria
        self.nome = nome


class Pergunta:
    def __init__(self, id_pergunta, enunciado, alternativa_a, alternativa_b, alternativa_c, alternativa_d, resposta_correta, id_categoria):
        self.id_pergunta = id_pergunta
        self.enunciado = enunciado
        self.alternativa_a = alternativa_a
        self.alternativa_b = alternativa_b
        self.alternativa_c = alternativa_c
        self.alternativa_d = alternativa_d
        self.resposta_correta = resposta_correta
        self.id_categoria = id_categoria


class Partida:
    def __init__(self, id_partida, pontuacao, total_acertos, data_partida, id_categoria):
        self.id_partida = id_partida
        self.pontuacao = pontuacao
        self.total_acertos = total_acertos
        self.data_partida = data_partida
        self.id_categoria = id_categoria
