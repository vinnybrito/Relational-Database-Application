-- Aula 13 - Junção de Tabelas 
-- (10-Mai-2023)

-- FUNÇÕES DE DATAS
-- Data do sistema: sysdate

----------------- SYSDATE -----------------

-- Exibindo a data do sistema - vendo o padrão atual
SELECT sysdate FROM dual;

-- Tabela da atividade 04
SELECT * FROM vendedor;

-- Criar as colunas dt_adm e dt_dem na tabela vendedor e incluir a data de hoje nelas
-- default sysdate, significa inserir a data do sistema na criação da coluna.

ALTER TABLE vendedor ADD dt_adm DATE DEFAULT sysdate;
ALTER TABLE vendedor ADD dt_dem DATE DEFAULT sysdate;

----------------------------------

-- PROCESSAMENTO COM DATAS: 
    data + número = data
    data - número = data
    data - data = número

SELECT sysdate, sysdate + 400, sysdate - 400 FROM dual;

-- Subtrair 3580 dias da data de admissão dos vendedores de comissão A.
UPDATE vendedor SET dt_adm = dt_adm - 3580 
WHERE comissao = 'A';

SELECT * FROM vendedor ORDER BY comissao;

-- Subtrair 6580 dias da data de admissão dos vendedores de comissão B
UPDATE vendedor SET dt_adm = dt_adm - 6580 
WHERE comissao = 'B';

-- Subtrair 13580 dias da data de admissão dos vendedores de comissão C
UPDATE vendedor SET dt_adm = dt_adm - 13580 
WHERE comissao = 'C';

-- Subtrair 18 dias da data de demissão do vendedor Felipe 
UPDATE vendedor SET dt_dem = dt_dem - 18 
WHERE nome_ven IN 'Felipe';

-- Apagar o conteúdo da coluna data de demisão dos vendedores de código: 101 a 310 (inclusive)
UPDATE vendedor SET dt_adm = NULL 
WHERE cod_ven BETWEEN 101 AND 310;

-- Subtrair 67 dias da data de demissão do vendedor Joao de código 11.
UPDATE vendedor SET dt_dem = dt_dem - 67 
WHERE nome_ven = 'Joao' AND cod_ven = 11;
COMMIT;

-- Crie um relatório que exiba o tempo de cada funcionário na empresa, 
-- mostre seu nome e tempo. Mostre os funcionários que trabalham na 
-- empresa a mais de 5 anos, exibe nome e tempo.

----------------------------------
-- JUNÇÃO DE TABELAS
----------------------------------
-- Consultas usando dados demais de uma tabela através do relacionamento.

-- 1) Criar um relatório que mostre o nome dos funcionários e seus cargos(nome)
-- junção por igualdade ou equivalência - inner join

SELECT nm_fun, nm_cargo FROM cargo 
INNER JOIN funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 2) Exiba os cargos com seus funcionários e caso exista um cargo que não tenha conexão
-- com algum funcionário,mostre ele tb.
/*
    Junção por equivalência e diferença ao mesmo tempo - esquerda ou direita - 
    left join ou right join.
*/

SELECT * FROM cargo;
SELECT * FROM funcionario;

SELECT nm_fun, nm_cargo FROM cargo 
LEFT JOIN funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 3) Exiba os cargos com seus funcionários e caso exista um funcionário 
-- que não tenha conexão com algum cargo, mostre ele tb.

SELECT nm_fun, nm_cargo FROM cargo 
RIGHT JOIN funcionario ON cd_cargo = cargo_fk;

------------------------------------

-- 4) Criar um relatório que mostre a diferença entre as tabelas
-- left ou right + pesquisa sobre conteúdo null na fk.

SELECT nm_fun, nm_cargo FROM cargo 
RIGHT JOIN funcionario ON cd_cargo = cargo_fk
WHERE cargo_fk IS NULL;

SELECT nm_fun, nm_cargo FROM cargo 
LEFT JOIN funcionario ON cd_cargo = cargo_fk
WHERE cargo_fk IS NULL;

-- Ou tudo em um único relatório.
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

