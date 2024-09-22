-- CHECKPOINT 02 - 1TDSPR - 2023
-- (26-Abr-2023)

-- PROJETO: Musica e CDs
-- OBJETIVO: Crie as instru��es sql de acordo com as tabelas abaixo.

DROP TABLE Cds CASCADE CONSTRAINTS;
DROP TABLE Musicas CASCADE CONSTRAINTS;

-- 1. Criar as tabelas.

CREATE TABLE Cds (
    Codigo NUMBER(3) PRIMARY KEY,
    Nome VARCHAR(50),
    DataCompra DATE,
    ValorPago NUMBER(8,2),
    LocalCompra VARCHAR(20),
    Album CHAR(1)
);

CREATE TABLE Musicas (
    CodigoCD NUMBER(3) REFERENCES Cds (Codigo), 
    Numero NUMBER(2),
    Nome VARCHAR(50),
    Artista VARCHAR(50),
    Tempo NUMBER(4),
    PRIMARY KEY (CodigoCD, Numero)
);

-- 2. Inserir para a tabela Cds 4 e para a tabela m�sica 2 m�sicas por CD.

INSERT INTO Cds VALUES (01, 'Metalica', '25-Ago-21', 90.90, 'Submarino', '1');
INSERT INTO Cds VALUES (02, 'Charlie Brown Jr', '15-Dez-22', 190.50, 'Lojas Americanas', '5');
INSERT INTO Cds VALUES (03, 'Iron Maiden', '17-Mai-16', 299.90, 'Submarino', '9');
INSERT INTO Cds VALUES (04, 'AC/DC', '07-Fev-11', 60.10, 'FastShop', '3');
INSERT INTO Cds VALUES (05, 'Avenged Sevenfold', '07-Jul-11', 60.10, 'Submarino', '4');
COMMIT;

SELECT * FROM Cds;

INSERT INTO Musicas VALUES (01, 1, 'Nothing Else Matters', 'Jos� Pedro', 2);
INSERT INTO Musicas VALUES (01, 2, 'Enter Sandman', 'James Hetfield', 5);
INSERT INTO Musicas VALUES (02, 1, 'C�u Azul', 'Chor�o', 3);
INSERT INTO Musicas VALUES (02, 2, 'S� os loucos sabem', 'Jos� Pedro', 4);
INSERT INTO Musicas VALUES (03, 1, 'Fear of the Dark', 'Bruce Dickinson', 7);
INSERT INTO Musicas VALUES (03, 2, 'Blood Brothers', 'Bruce Dickinson', 7);
INSERT INTO Musicas VALUES (04, 1, 'Highway to Hell', 'Jos� Pedro', 3);
INSERT INTO Musicas VALUES (04, 2, 'Back in Black', 'Brian Johnson', 4);
INSERT INTO Musicas VALUES (05, 1, 'A Little Piece of Heaven', 'Jos� Pedro', 3);
INSERT INTO Musicas VALUES (05, 2, 'Afterlide', 'Brian Johnson', 4);
COMMIT;

SELECT * FROM Musicas;

-- 3. Mostrar os campos nome e data da compra dos cds ordenados por nome.
SELECT Nome, DataCompra FROM Cds ORDER BY nome;

-- 4. Mostrar todas as m�sicas (todos os campos) do cd de c�digo 1 com 
-- tempo entre 2 e 3 minutos (inclusive)
SELECT * FROM Musicas
WHERE CodigoCD = 1 AND Tempo BETWEEN 2 AND 3; 

-- 5. Mostre o n�mero, nome e tempo das m�sicas do cd 5 em ordem de n�mero.
SELECT Numero, Nome, Tempo FROM Musicas
WHERE CodigoCD = 5 ORDER BY Numero;

-- 6. Mostre o nome das m�sicas do artista Jos� Pedro.
SELECT Nome FROM Musicas
WHERE Artista = 'Jos� Pedro';

-- 7. Mostre o nome de todos cds comprados no Submarino.
SELECT Nome FROM Cds
WHERE LocalCompra = 'Submarino';
