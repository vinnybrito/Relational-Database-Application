-- Aula 14 - Checkpoint 03 - 1TDSPR - 2023
-- (17-Mai-2023)

DROP TABLE Automovel CASCADE CONSTRAINTS;
DROP TABLE Revendedora CASCADE CONSTRAINTS;
DROP TABLE Consumidor CASCADE CONSTRAINTS;
DROP TABLE Negocio CASCADE CONSTRAINTS;
DROP TABLE Garagem CASCADE CONSTRAINTS;

CREATE TABLE Automovel (
    Codigo NUMBER(4) PRIMARY KEY,
    Fabricante VARCHAR2(20),
    Modelo VARCHAR2(10),
    Ano NUMBER(4),
    Pais VARCHAR2(15),
    Preco_tabela NUMBER(8,2)
);

CREATE TABLE Revendedora (
    Cnpj VARCHAR2(14) PRIMARY KEY,
    Nome VARCHAR2(20),
    Proprietario VARCHAR2(20),
    Cidade VARCHAR2(15),
    uf CHAR(2)
);

CREATE TABLE Consumidor (
    Identidade NUMBER(4) PRIMARY KEY,
    Nome VARCHAR2(20),
    Sobrenome VARCHAR2(10)
);

CREATE TABLE Negocio (
    AnoAuto NUMBER(4),
    Data DATE,
    Preco NUMBER(8,2),
    Comprador NUMBER(4),
    Revenda VARCHAR2(14),
    CodAuto NUMBER(4),
    FOREIGN KEY(Comprador) REFERENCES Consumidor (Identidade),
    FOREIGN KEY(Revenda) REFERENCES Revendedora (cnpj),
    FOREIGN KEY(CodAuto) REFERENCES Automovel (Codigo)
);

CREATE TABLE Garagem (
    AnoAuto NUMBER(4),
    Quantidade NUMBER(4),
    cnpjRevenda VARCHAR2(14),
    CodAuto NUMBER(4),
    FOREIGN KEY(cnpjRevenda) REFERENCES Revendedora (cnpj),
    FOREIGN KEY(CodAuto) REFERENCES Automovel (Codigo)
);

DELETE FROM Automovel;
DELETE FROM Revendedora;
DELETE FROM Consumidor;
DELETE FROM Negocio;
DELETE FROM Garagem;

INSERT INTO Automovel VALUES (10, 'Honda','Civic', 2008, 'Japao', '45000');
INSERT INTO Automovel VALUES (20, 'Honda', 'Fit', 2005, 'Japao', '25500');
INSERT INTO Automovel VALUES (30, 'Pegeout', '306', 2006, 'Franca', '35780');
INSERT INTO Automovel VALUES (40, 'Citroen', 'Xantia', 2000, 'Franca', '8500');
INSERT INTO Automovel VALUES (50, 'Volkswagem', 'Fusca', 2011, 'Alemanha', '35000');
INSERT INTO Automovel VALUES (60, 'Volkswagem', 'Voyage', 2010, 'Alemanha', 27899);

INSERT INTO Revendedora VALUES ('1111111', 'Automodelo', 'Ronaldo', 'São Paulo', 'SP');
INSERT INTO Revendedora VALUES ('2222222', 'Best Cars', 'Francisco', 'Rio de Janeiro', 'RJ');
INSERT INTO Revendedora VALUES ('3333333', 'Roma Veículos', 'Joana', 'Bahia', 'BA');
INSERT INTO Revendedora VALUES ('4444444', 'Já Era Autos', 'Marcel', 'São Paulo', 'SP');

INSERT INTO Consumidor VALUES (1, 'Carlos', 'Andrade');
INSERT INTO Consumidor VALUES (2, 'Simone', 'Freitas');
INSERT INTO Consumidor VALUES (3, 'Gilmar', 'Silva');
INSERT INTO Consumidor VALUES (4, 'Rosana', 'Gonçalves');

INSERT INTO Negocio VALUES (2005, '03/05/2010', 26700,1, '1111111', 20);
INSERT INTO Negocio VALUES (2010, '01/01/2011', 35000,2, '3333333', 60);
INSERT INTO Negocio VALUES (2000, '13/07/2010', 7000,1, '2222222', 40);
INSERT INTO Negocio VALUES (2006, '22/12/2010', 30000,3, '4444444', 30);
INSERT INTO Negocio VALUES (2011, '10/06/2011', 35500,4, '2222222', 50);
INSERT INTO Negocio VALUES (2005, '04/09/2009', 26000,3, '2222222', 20);

INSERT INTO Garagem VALUES (2005, 3, 1111111 ,20);
INSERT INTO Garagem VALUES (2000, 1, 2222222 ,40);
INSERT INTO Garagem VALUES (2011, 7, 2222222, 50);
INSERT INTO Garagem VALUES (2005, 6, 2222222, 20);
INSERT INTO Garagem VALUES (2010, 1, 3333333, 60);
INSERT INTO Garagem VALUES (2006, 4, 4444444, 30);
COMMIT;

---------------------------------

-- Questões

-- 1ª) Mostre quantos fabricantes diferentes estão cadastrados.
SELECT 
    COUNT(DISTINCT fabricante) "Fabricantes cadastrados" 
FROM 
    Automovel;

-- 2ª) Mostre quais revendedoras vendem o modelo Xantia.
SELECT 
    nome "REVENDEDORA" 
FROM 
    Revendedora
INNER JOIN 
    Negocio ON Revendedora.cnpj = Negocio.revenda
INNER JOIN 
    Automovel ON Negocio.CodAuto = Automovel.codigo
WHERE 
    Automovel.modelo = 'Xantia';

-- 3ª) Mostre o nome e a cidade do revendedor que não possuí veículo francês.
SELECT 
    nome "Nome", 
    cidade "Cidade" 
FROM 
    Revendedora
LEFT JOIN 
    Negocio ON Revendedora.cnpj = Negocio.revenda
LEFT JOIN 
    Automovel ON Negocio.CodAuto = Automovel.codigo
WHERE 
    Automovel.pais <> 'Franca' OR Automovel.pais IS NULL;

-- 4ª) Mostre o maior e o menor preço de tabela dos veículos.
SELECT 
    MAX(preco_tabela) "Maior preço", 
    MIN(preco_tabela) "Menor preço" 
FROM 
    Automovel;

-- 5ª) Mostre o nome, modelo dos veículos, preço da tabela, preço da tabela com aumento de 10%.
SELECT 
    Fabricante, 
    Modelo, 
    Preco_tabela, 
    (Preco_tabela * 1.1) "TABELA_COM_AUMENTO"
FROM 
    Automovel;

-- 6ª) Exiba a quantidade de carros comprados por Consumidor.
SELECT 
    nome, 
    COUNT(Negocio.CodAuto) "CARROS_COMPRADOS" 
FROM 
    Consumidor
LEFT JOIN 
    Negocio ON Consumidor.identidade = Negocio.comprador
GROUP BY nome;

-- 7ª) Listar os automóveis italianos e japoneses ordenados por código (crescente), ano e preço de tabela.
SELECT * FROM 
    Automovel
WHERE 
    pais IN ('Italia', 'Japao')
ORDER BY 1, 4, 6 ASC;

-- 8ª) Qual o carro de preço de tabela é o mais caro?
SELECT 
    modelo, 
    preco_tabela 
FROM 
    Automovel
WHERE 
    preco_tabela = (
        SELECT 
            MAX(preco_tabela) 
        FROM 
            Automovel
    );

-- 9ª) Qual seria o lucro da revendedora Automodelo caso tivesse vendido seus carros por um valor 10%
-- maior, supondo os preços de tabela estáveis?
SELECT 
    SUM((n.Preco * 0.1)) "LUCRO_REVENDEDORA" 
FROM 
    Negocio n
INNER JOIN 
    Revendedora r ON n.Revenda = r.Cnpj
WHERE 
    r.Nome = 'Automodelo';

-- 10ª) Mostar os dados dos consumidores.
SELECT * FROM Consumidor;
