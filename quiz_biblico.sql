-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10/11/2026 às 23:58
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `quiz_biblico`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nome`) VALUES
(1, 'Conhecimentos Bíblicos');

-- --------------------------------------------------------

--
-- Estrutura para tabela `partidas`
--

CREATE TABLE `partidas` (
  `id_partida` int(11) NOT NULL,
  `pontuacao` int(11) NOT NULL,
  `total_acertos` int(11) NOT NULL,
  `data_partida` datetime DEFAULT current_timestamp(),
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `partidas`
--

INSERT INTO `partidas` (`id_partida`, `pontuacao`, `total_acertos`, `data_partida`, `id_categoria`) VALUES
(1, 8, 8, '2026-11-10 16:43:34', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `perguntas`
--

CREATE TABLE `perguntas` (
  `id_pergunta` int(11) NOT NULL,
  `enunciado` varchar(255) NOT NULL,
  `alternativa_a` varchar(150) NOT NULL,
  `alternativa_b` varchar(150) NOT NULL,
  `alternativa_c` varchar(150) NOT NULL,
  `alternativa_d` varchar(150) NOT NULL,
  `resposta_correta` char(1) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `perguntas`
--

INSERT INTO `perguntas` (`id_pergunta`, `enunciado`, `alternativa_a`, `alternativa_b`, `alternativa_c`, `alternativa_d`, `resposta_correta`, `id_categoria`) VALUES
(1, 'Quem construiu a arca?', 'Moisés', 'Noé', 'Abraão', 'Davi', 'B', 1),
(2, 'Quem derrotou Golias?', 'Saul', 'Samuel', 'Davi', 'Salomão', 'C', 1),
(3, 'Em qual cidade Jesus nasceu?', 'Nazaré', 'Belém', 'Jerusalém', 'Roma', 'B', 1),
(4, 'Quem recebeu os Dez Mandamentos?', 'Moisés', 'Pedro', 'Paulo', 'José', 'A', 1),
(5, 'Qual foi o primeiro livro da Bíblia?', 'Êxodo', 'Salmos', 'Gênesis', 'Mateus', 'C', 1),
(6, 'Quem traiu Jesus?', 'Pedro', 'Judas Iscariotes', 'João', 'Tomé', 'B', 1),
(7, 'Quem foi engolido por um grande peixe?', 'Jonas', 'Elias', 'Isaías', 'Daniel', 'A', 1),
(8, 'Qual era a profissão de Pedro antes de seguir Jesus?', 'Carpinteiro', 'Soldado', 'Pescador', 'Médico', 'C', 1),
(9, 'Quem foi lançado na cova dos leões?', 'Davi', 'Daniel', 'José', 'Moisés', 'B', 1),
(10, 'Quantos discípulos Jesus escolheu?', '7', '10', '12', '15', 'C', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices de tabela `partidas`
--
ALTER TABLE `partidas`
  ADD PRIMARY KEY (`id_partida`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Índices de tabela `perguntas`
--
ALTER TABLE `perguntas`
  ADD PRIMARY KEY (`id_pergunta`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `partidas`
--
ALTER TABLE `partidas`
  MODIFY `id_partida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `perguntas`
--
ALTER TABLE `perguntas`
  MODIFY `id_pergunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `partidas`
--
ALTER TABLE `partidas`
  ADD CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);

--
-- Restrições para tabelas `perguntas`
--
ALTER TABLE `perguntas`
  ADD CONSTRAINT `perguntas_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
