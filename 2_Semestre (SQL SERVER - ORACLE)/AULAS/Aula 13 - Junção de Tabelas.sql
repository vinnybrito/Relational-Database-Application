-- Aula 13 - Jun??o de Tabelas 
-- (10-Mai-2023)

-- FUN��ES DE DATAS
-- Data do sistema: sysdate

----------------- SYSDATE -----------------

-- Exibindo a data do sistema - vendo o padr?o atual
SELECT sysdate FROM dual;

-- Tabela da atividade 04
SELECT * FROM vendedor;

-- Criar as colunas dt_adm e dt_dem na tabela vendedor e incluir a data de hoje nelas
-- default sysdate, significa inserir a data do sistema na cria??o da coluna.

ALTER TABLE vendedor ADD dt_adm DATE DEFAULT sysdate;
ALTER TABLE vendedor ADD dt_dem DATE DEFAULT sysdate;

----------------------------------

-- PROCESSAMENTO COM DATAS: 
    data + numero = data
    data - numero = data
    data - data = numero

SELECT sysdate, sysdate + 400, sysdate - 400 FROM dual;

-- Subtrair 3580 dias da data de admiss?o dos vendedores de comiss?o A.
UPDATE vendedor SET dt_adm = dt_adm - 3580 
WHERE comissao = 'A';

SELECT * FROM vendedor ORDER BY comissao;

-- Subtrair 6580 dias da data de admiss?o dos vendedores de comiss?o B
UPDATE vendedor SET dt_adm = dt_adm - 6580 
WHERE comissao = 'B';

-- Subtrair 13580 dias da data de admiss?o dos vendedores de comiss?o C
UPDATE vendedor SET dt_adm = dt_adm - 13580 
WHERE comissao = 'C';

-- Subtrair 18 dias da data de demiss?o do vendedor Felipe 
UPDATE vendedor SET dt_dem = dt_dem - 18 
WHERE nome_ven IN 'Felipe';

-- Apagar o conte?do da coluna data de demis?o dos vendedores de c?digo: 101 a 310 (inclusive)
UPDATE vendedor SET dt_adm = NULL 
WHERE cod_ven BETWEEN 101 AND 310;

-- Subtrair 67 dias da data de demiss?o do vendedor Joao de c?digo 11.
UPDATE vendedor SET dt_dem = dt_dem - 67 
WHERE nome_ven = 'Joao' AND cod_ven = 11;
COMMIT;

-- Crie um relatorio que exiba o tempo de cada funcionario na empresa, 
-- mostre seu nome e tempo. Mostre os funcionarios que trabalham na 
-- empresa a mais de 5 anos, exibe nome e tempo.

----------------------------------
-- JUNCAO DE TABELAS
----------------------------------
-- Consultas usando dados demais de uma tabela atraves do relacionamento.

DROP TABLE Cargo CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;

CREATE TABLE Cargo (
    cd_cargo NUMBER(2) PRIMARY KEY,
    nm_cargo VARCHAR2(20) NOT NULL,
    salario NUMBER(8,2)
);

CREATE TABLE Funcionario (
    id_fun NUMBER(2) NOT NULL,
    nm_fun VARCHAR2(20) NOT NULL,
    cargo_fk NUMBER(2) REFERENCES Cargo (cd_cargo)
);

INSERT INTO Cargo VALUES (1, 'Prg. Web', 4500);
INSERT INTO Cargo VALUES (2, 'DBA', 12000);
INSERT INTO Cargo VALUES (3, 'Analista Dados', 8000);

INSERT INTO Funcionario VALUES (10, 'Marcel', 1);
INSERT INTO Funcionario VALUES (11, 'Claudio', 2);
INSERT INTO Funcionario VALUES (12, 'Amanda', 2);
INSERT INTO Funcionario VALUES (13, 'Samantha', NULL);
COMMIT;

-- 1) Criar um relatorio que mostre o nome dos funcionarios e seus cargos(nome)
-- juncaoo por igualdade ou equivalencia - inner join

SELECT 
    nm_fun "Funcionario", 
    nm_cargo "Cargo"
FROM 
    Cargo 
INNER JOIN 
    Funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 2) Exiba os cargos com seus funcionarios e caso exista um cargo que nao tenha conexao
-- com algum funcionario, mostre ele tambem.
/*
    Juncao por equivalencia e diferenca ao mesmo tempo - esquerda ou direita - 
    LEFT JOIN ou RIGHT JOIN.
*/

SELECT 
    nm_fun "Funcionario", 
    nm_cargo "Cargo"
FROM 
    Cargo 
LEFT JOIN 
    Funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 3) Exiba os cargos com seus funcionarios e caso exista um funcionario 
-- que nao tenha conexao com algum cargo, mostre ele tambem.

SELECT 
    nm_fun "Funcionario", 
    nm_cargo "Cargo"
FROM 
    Cargo 
RIGHT JOIN 
    Funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 4) Criar um relatorio que mostre a diferenca entre as tabelas
-- LEFT ou RIGHT + pesquisa sobre conteudo NULL na FK.

SELECT 
    nm_fun "Funcionario", 
    nm_cargo "Cargo"
FROM 
    Cargo 
RIGHT JOIN 
    Funcionario ON cd_cargo = cargo_fk
WHERE 
    cargo_fk IS NULL;

---

SELECT 
    nm_fun "Funcionario", 
    nm_cargo "Cargo"
FROM 
    Cargo 
LEFT JOIN 
    Funcionario ON cd_cargo = cargo_fk
WHERE 
    cargo_fk IS NULL;

---

-- Ou tudo em um unico relatorio.
SELECT 
    nm_fun "Funcionario", 
    nm_cargo "Cargo"
FROM 
    Cargo 
FULL OUTER JOIN 
    Funcionario ON cd_cargo = cargo_fk
WHERE 
    cargo_fk IS NULL;

------------------------------------

-- 5) Exiba o nome do cliente e o seu pedido
SELECT 
    nome_clie "Cliente", 
    num_pedido 
FROM 
    Cliente
INNER JOIN pedido ON cod_clie = cod_clie;

DESC Cliente;

-- 6) Exiba o nome do vendedor e o seu pedido
SELECT 
    nome_ven "Vendedor", 
    num_pedido "Pedido"
FROM 
    Vendedor
INNER JOIN 
    Pedido ON Pedido.cod_ven = Vendedor.cod_ven;

-- 7) Exiba o nome do cliente, do vendedor e o seu pedido
SELECT 
    nome_ven "Vendedor", 
    num_pedido "Pedido", 
    nome_clie "Cliente"
FROM 
    Pedido
INNER JOIN 
    Vendedor ON Pedido.cod_ven = Vendedor.cod_ven
INNER JOIN 
    Cliente ON Pedido.cod_clie = Cliente.cod_clie;

