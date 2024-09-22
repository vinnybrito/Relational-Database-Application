-- Atividade 03 - Locadora de Videos

-----------------------------------------
		TAREFA 01
-----------------------------------------

-- 1) Criar todas as tabelas, de acordo com o modelo relacional/l�gico,
-- definindo todas as restri��es mencionadas no modelo;

SELECT table_name FROM user_tables; -- Utilizado para visualizar todas as tabelas;

DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Filme CASCADE CONSTRAINTS;
DROP TABLE DVD CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Ator CASCADE CONSTRAINTS;
DROP TABLE Aluga CASCADE CONSTRAINTS;
DROP TABLE Estrela CASCADE CONSTRAINTS;

CREATE TABLE Categoria (
    Codcateg NUMBER(4) PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL
);

CREATE TABLE Filme (
    CodFime NUMBER(4) PRIMARY KEY,
    Titulo VARCHAR(70) NOT NULL,
    Codcateg REFERENCES Categoria
);

CREATE TABLE DVD (
    NumDVD NUMBER(4) PRIMARY KEY,
    CodFime REFERENCES Filme,
    Tipo CHAR(1)
);

CREATE TABLE Cliente (
    CodCli NUMBER(4) PRIMARY KEY,
    Prenome VARCHAR(50) NOT NULL, 
    Sobrenome VARCHAR(50),
    Endereco VARCHAR(70),
    Telefone VARCHAR(20)
);

CREATE TABLE Ator (
    Codator NUMBER(4) PRIMARY KEY,
    Nome_popular VARCHAR(50) NOT NULL,
    Nome_artistico VARCHAR(50),
    Datanasc DATE
);

CREATE TABLE Aluga (
    CodClie REFERENCES cliente,
    NumDVD REFERENCES DVD,
    DataRet DATE,
    DataDev DATE,
    Num_aluga NUMBER(4) PRIMARY KEY
);

CREATE TABLE Estrela (
    CodAtor REFERENCES Ator,
    CodFilme REFERENCES Filme
);

-----------------------------------------
		TAREFA 02
-----------------------------------------

-- 2-) Insira todos os valores apresentados nas tabelas FILME, CLIENTE, DVD e CATEGORIA.
-- (Utilize v�rios insert's).

-- Tabela Categoria
INSERT INTO Categoria VALUES (1, 'Com�dia');
INSERT INTO Categoria VALUES (2, 'Drama');
INSERT INTO Categoria VALUES (3, 'Aventura');
INSERT INTO Categoria VALUES (4, 'Terror');
COMMIT;

SELECT * FROM Categoria;

-- Tabela Filme
INSERT INTO Filme VALUES (1, 'Sai pra l�', 1);
INSERT INTO Filme VALUES (2, 'Ajuda Eterna', 2);
INSERT INTO Filme VALUES (3, 'Anjos Malditos', 2);
INSERT INTO Filme VALUES (4, 'P�nico II', 4);
INSERT INTO Filme VALUES (5, 'Um dia de furia', 3);
INSERT INTO Filme VALUES (6, 'Lente Cega', 3);
INSERT INTO Filme VALUES (7, 'Sinais do Tempo', 2);
INSERT INTO Filme VALUES (8, 'A melodia da vida', 1);
COMMIT;

SELECT * FROM Filme;

-- Tabela DVD
INSERT INTO DVD VALUES (1, 1, 'S');
INSERT INTO DVD VALUES (2, 1, 'S');
INSERT INTO DVD VALUES (3, 1, 'S');
INSERT INTO DVD VALUES (4, 2, 'D');
INSERT INTO DVD VALUES (5, 3, 'S');
COMMIT;

SELECT * FROM DVD;

-- Tabela Cliente
INSERT INTO Cliente VALUES
    (1, 'Jo�o', 'Silva', 'Rua da Cruz sem P�', '4444-1111');
INSERT INTO Cliente VALUES
    (2, 'Ant�nio', 'Ferreira', 'Av. da Vila Velha', '6660-9333');
INSERT INTO Cliente VALUES
    (3, 'Fabio', 'Dias', 'Rua Antonio Vieira', '2337-0393');
INSERT INTO Cliente VALUES
    (4, 'Andreia', 'Melo', 'Rua da Praia Bonita', '8989-7777');
INSERT INTO Cliente VALUES
    (5, 'Murilo', 'Fontes', 'Av. dos Autonomistas', '9090-9090');
COMMIT;
    
SELECT * FROM Cliente;

-- Tabela Ator
INSERT INTO Ator VALUES 
    (1, 'Leonardo DiCaprio', 'Leo DiCaprio', '11-Nov-1974');
INSERT INTO Ator VALUES 
    (2, 'Scarlett Johansson', 'ScarJo', '22-Nov-1984');
INSERT INTO Ator VALUES 
    (3, 'Robert Downey Jr.', 'RDJ', '04-Abr-1965');
INSERT INTO Ator VALUES 
    (4, 'Angelina Jolie', 'Angie', '04-Jun-1975');
INSERT INTO Ator VALUES 
    (5, 'Brad Pitt', 'Brad Pitt', '18-Dez-1963');
COMMIT;
    
SELECT * FROM Ator;
    
-- Tabela Estrela
INSERT INTO Estrela VALUES (1, 1);
INSERT INTO Estrela VALUES (2, 2);
INSERT INTO Estrela VALUES (3, 3);
INSERT INTO Estrela VALUES (4, 4);
INSERT INTO Estrela VALUES (5, 5);
COMMIT;

SELECT * FROM Estrela;

-- Tabela Aluga
INSERT INTO Aluga VALUES (1, 1, '01-Set-2024', '10-Set-2024', 1);
INSERT INTO Aluga VALUES (2, 2, '02-Set-2024', '12-Set-2024', 2);
INSERT INTO Aluga VALUES (3, 3, '03-Set-2024', '15-Set-2024', 3);
COMMIT;

SELECT * FROM Aluga;

-- Visualizar todos os inserts;
SELECT * FROM Categoria;
SELECT * FROM Filme;
SELECT * FROM DVD;
SELECT * FROM Cliente;
SELECT * FROM Ator;
SELECT * FROM Aluga;
SELECT * FROM Estrela;

-----------------------------------------
		TAREFA 03
-----------------------------------------

-- 3-) Altere o n�mero da categoria C�media de 01 para 08 na tabela Categoria.

-- ( Esta altera��o n�o pode ser realizada diretamente na PRIMARY KEY, 
--   pois existem dados na FOREIGN KEY que s�o os mesmos da PK. )

-- Passo 1: Realizar a troca dos dados da fk para null;

SELECT * FROM Filme;

UPDATE Filme SET Codcateg = NULL 
WHERE Codcateg = 1;

-- Passo 2: Trocar o valor da PK de 1 para 8;

SELECT * FROM Categoria;

UPDATE Categoria SET Codcateg = 8
WHERE Codcateg = 1 AND Descricao = 'Com�dia';

-- Passo 3: Atualiza as fks nulas para 8;

SELECT * FROM Filme;

UPDATE Filme SET Codcateg = 8
WHERE Codcateg IS NULL;
COMMIT;

-----------------------------------------
		TAREFA 04
-----------------------------------------

-- 4-) Insira a coluna SINOPSE na tabela FILME com 300 caracteres.

SELECT * FROM Filme;

ALTER TABLE Filme ADD Sinopse VARCHAR(300);

-----------------------------------------
		TAREFA 05
-----------------------------------------

-- 5-) Cadastre uma nova categoria de filme chamada FIC��O.

SELECT * FROM Categoria;

INSERT INTO Categoria VALUES (5, 'Fic��o');

-----------------------------------------
		TAREFA 06
-----------------------------------------

-- 6-) Apague o filme chamado "Anjos Malditos" e a "A melodia da Vida" da tabela Filme.
-- Para isso, utilize um �nico comando.

SELECT * FROM Filme;
SELECT * FROM DVD;
SELECT * FROM Estrela;

-- Remover a FOREIGN KEY dos FIlmes, da tabela DVD.
DELETE FROM DVD WHERE NumDVD = 5;

-- Remover a FOREIGN KEY dos FIlmes, da tabela Estrela.
DELETE FROM Estrela WHERE CodAtor = 3 AND CodFilme = 3;

-- Apagar os filmes da tabela Filme.
DELETE FROM Filme
WHERE Titulo = 'Anjos Malditos' OR Titulo = 'A melodia da vida';
