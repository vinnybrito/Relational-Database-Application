-- Aula 13 - Jun��o de Tabelas 
-- (10-Mai-2023)

-- FUNÇÕES DE DATAS
-- Data do sistema: sysdate

----------------- SYSDATE -----------------

-- Exibindo a data do sistema - vendo o padr�o atual
SELECT sysdate FROM dual;

-- Tabela da atividade 04
SELECT * FROM vendedor;

-- Criar as colunas dt_adm e dt_dem na tabela vendedor e incluir a data de hoje nelas
-- default sysdate, significa inserir a data do sistema na cria��o da coluna.

ALTER TABLE vendedor ADD dt_adm DATE DEFAULT sysdate;
ALTER TABLE vendedor ADD dt_dem DATE DEFAULT sysdate;

----------------------------------

-- PROCESSAMENTO COM DATAS: 
    data + n�mero = data
    data - n�mero = data
    data - data = n�mero

SELECT sysdate, sysdate + 400, sysdate - 400 FROM dual;

-- Subtrair 3580 dias da data de admiss�o dos vendedores de comiss�o A.
UPDATE vendedor SET dt_adm = dt_adm - 3580 
WHERE comissao = 'A';

SELECT * FROM vendedor ORDER BY comissao;

-- Subtrair 6580 dias da data de admiss�o dos vendedores de comiss�o B
UPDATE vendedor SET dt_adm = dt_adm - 6580 
WHERE comissao = 'B';

-- Subtrair 13580 dias da data de admiss�o dos vendedores de comiss�o C
UPDATE vendedor SET dt_adm = dt_adm - 13580 
WHERE comissao = 'C';

-- Subtrair 18 dias da data de demiss�o do vendedor Felipe 
UPDATE vendedor SET dt_dem = dt_dem - 18 
WHERE nome_ven IN 'Felipe';

-- Apagar o conte�do da coluna data de demis�o dos vendedores de c�digo: 101 a 310 (inclusive)
UPDATE vendedor SET dt_adm = NULL 
WHERE cod_ven BETWEEN 101 AND 310;

-- Subtrair 67 dias da data de demiss�o do vendedor Joao de c�digo 11.
UPDATE vendedor SET dt_dem = dt_dem - 67 
WHERE nome_ven = 'Joao' AND cod_ven = 11;
COMMIT;

-- Crie um relat�rio que exiba o tempo de cada funcion�rio na empresa, 
-- mostre seu nome e tempo. Mostre os funcion�rios que trabalham na 
-- empresa a mais de 5 anos, exibe nome e tempo.

----------------------------------
-- JUN��O DE TABELAS
----------------------------------
-- Consultas usando dados demais de uma tabela atrav�s do relacionamento.

-- 1) Criar um relat�rio que mostre o nome dos funcion�rios e seus cargos(nome)
-- jun��o por igualdade ou equival�ncia - inner join

SELECT nm_fun, nm_cargo FROM cargo 
INNER JOIN funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 2) Exiba os cargos com seus funcion�rios e caso exista um cargo que n�o tenha conex�o
-- com algum funcion�rio,mostre ele tb.
/*
    Jun��o por equival�ncia e diferen�a ao mesmo tempo - esquerda ou direita - 
    left join ou right join.
*/

SELECT * FROM cargo;
SELECT * FROM funcionario;

SELECT nm_fun, nm_cargo FROM cargo 
LEFT JOIN funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 3) Exiba os cargos com seus funcion�rios e caso exista um funcion�rio 
-- que n�o tenha conex�o com algum cargo, mostre ele tb.

SELECT nm_fun, nm_cargo FROM cargo 
RIGHT JOIN funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 4) Criar um relat�rio que mostre a diferen�a entre as tabelas
-- left ou right + pesquisa sobre conte�do null na fk.

SELECT nm_fun, nm_cargo FROM cargo 
RIGHT JOIN funcionario ON cd_cargo = cargo_fk
WHERE cargo_fk IS NULL;

SELECT nm_fun, nm_cargo FROM cargo 
LEFT JOIN funcionario ON cd_cargo = cargo_fk
WHERE cargo_fk IS NULL;

-- Ou tudo em um �nico relat�rio.
SELECT nm_fun, nm_cargo FROM cargo 
FULL OUTER JOIN funcionario ON cd_cargo = cargo_fk
WHERE cargo_fk IS NULL;

------------------------------------

-- 5) Exiba o nome do cliente e o seu pedido
SELECT nome_clie, num_pedido FROM cliente
INNER JOIN pedido ON cod_clie = cod_clie;

DESC cliente;

-- 6) Exiba o nome do vendedor e o seu pedido
SELECT nome_ven, num_pedido FROM vendedor
INNER JOIN pedido ON pedido.cod_ven = vendedor.cod_ven;

-- 7) Exiba o nome do cliente, do vendedor e o seu pedido
SELECT 
        nome_ven, 
        num_pedido, 
        nome_clie 
FROM pedido
INNER JOIN vendedor ON pedido.cod_ven = vendedor.cod_ven
INNER JOIN cliente ON pedido.cod_clie = cliente.cod_clie;

