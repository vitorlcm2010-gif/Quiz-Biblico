
CREATE DATABASE quiz_biblico;

USE quiz_biblico;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE perguntas (
    id_pergunta INT AUTO_INCREMENT PRIMARY KEY,
    enunciado VARCHAR(255) NOT NULL,
    alternativa_a VARCHAR(150) NOT NULL,
    alternativa_b VARCHAR(150) NOT NULL,
    alternativa_c VARCHAR(150) NOT NULL,
    alternativa_d VARCHAR(150) NOT NULL,
    resposta_correta CHAR(1) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE partidas (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    pontuacao INT NOT NULL,
    total_acertos INT NOT NULL,
    data_partida DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

INSERT INTO categorias (nome)
VALUES ('Conhecimentos Bíblicos');

INSERT INTO perguntas (
    enunciado,
    alternativa_a,
    alternativa_b,
    alternativa_c,
    alternativa_d,
    resposta_correta,
    id_categoria
)
VALUES (
    'Quem construiu a arca?',
    'Moisés',
    'Noé',
    'Abraão',
    'Davi',
    'B',
    1
);
