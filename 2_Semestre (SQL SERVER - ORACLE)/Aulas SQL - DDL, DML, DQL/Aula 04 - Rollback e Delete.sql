-- Aula 4 - Finalizando DML
-- (08-Mar-23)

------------------------------------

-- Sintaxe:

-- Eliminando todas as linha(s)
DELETE FROM nome_tabela;

-- Eliminando algumas linha(s)
DELETE FROM nome_tabela WHERE condição;

COMMIT;

------------------ ROLLBACK ------------------

SELECT * FROM produto_tb;

-- Apagando tudo
DELETE FROM produto_tb;

ROLLBACK;

DELETE FROM produto_tb WHERE cod_prod = 31;

-- Gravando os dados em disco: 
COMMIT;

-- Desfazendo DML:
ROLLBACK

-- Atenção: uma vez executado o commit, o rollback não funciona