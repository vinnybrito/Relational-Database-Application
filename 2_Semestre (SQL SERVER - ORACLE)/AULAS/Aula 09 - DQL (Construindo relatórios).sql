-- Aula 08 - Construindo relat�rios, comandos
-- (12-Abr-2023)

-- DQL: Data Query Language
-- Exibindo o conte�do de uma tabela, todas as linhas e colunas

-- Sintaxe b�sica: 
SELECT * FROM nome_tabela;

SELECT = sele��o
* = Todas as colunas
FROM = origem dos dados
nome_tabela = tabela destino do relat�rio

-- Os exemplos abaixo são referênte as tabelas criadas
-- na atividade 04

------------------------------------
-- EXEMPLOS: 
------------------------------------

-- 1) Exibir o conte�do da tabela cliente
SELECT * FROM cliente;

-- 1.1) Mostre o conte�do da tabela vendedor.
SELECT * FROM vendedor;

-- 1.2) Mostre o conte�do da tabela que possui os produtos e seus pedidos.
SELECT * FROM item_pedido;

------------------------------------

-- 2) Criando um relat�rio com colunas espec�ficas
-- Sintaxe: 
SELECT nome_col1, nome_col2 FROM nome_tabela;
--nome_col = nome da coluna a ser exibida

-- Mostrar o nome do cliente e o estado onde ele mora
SELECT nome_clie, uf FROM cliente;

-- 2.1) Exiba o nome do vendedor e seu sal�rio
SELECT nome_ven, salario_fixo FROM vendedor;

-- 2.2) Mostre o nome do produto e seu pre�o
SELECT descricao, val_unit FROM produto;

------------------------------------

-- 3) Classificando relat�rios
-- Sitaxe: select * from tabela order by nome_col asc (default) - crescente
-- Sitaxe: select * from tabela order by nome_col desc - decrescente

SELECT nome_clie, uf FROM cliente ORDER BY nome_clie ASC; -- (opcional)
SELECT nome_clie, uf FROM cliente ORDER BY 1 ASC; -- (opcional)
SELECT nome_clie, uf FROM cliente ORDER BY 1 DESC;
SELECT uf, nome_clie FROM cliente ORDER BY 1,2;
SELECT uf, nome_clie FROM cliente ORDER BY 1,2 DESC;

-- 3.1) Criar um relat�rio que mostre os pedidos organizados por n�mero (crescente), 
-- cliente e vendedor decrescente
SELECT * FROM pedido ORDER BY 1, 3 DESC, 4 DESC;

-- 3.2) Mostrar em ordem decrescente de sal�rio os dados dos vendedores
SELECT * FROM vendedor ORDER BY 3 DESC;

------------------------------------

-- 4) Apelidando colunas
-- Sintaxe: 
SELECT nome_col Apelido, nome_col "apelido da coluna" FROM tabela;

SELECT nome_clie Cliente, endereco "Local da morada" FROM cliente;

------------------------------------

-- 5) Usando filtro de linhas
-- Sintaxe: 
SELECT * FROM tabela WHERE nome_col operador valor

Operadores: 
        Aritm�ticos: + - * / ()
        Relacionais : > >= < <= = <> ou !=
        L�gicos: AND, OR, NOT
        BD: BETWEEN, IN, LIKE

-- 5.1) Crie um relat�rio que mostre qual ser� o sal�rio do vendedor com um aumento de 10%
SELECT salario_fixo "sal atual", salario_fixo * 1.1 "Sal Reaj 10%" FROM vendedor;

-- 5.2) Crie um relat�rio que exiba os clientes com nome e uf que morem no estado de SP
SELECT nome_clie, uf  FROM cliente 
WHERE UPPER(uf) = 'SP';

-- 5.3) Quais produtos custam abaixo de R$1,50? mostre em ordem crescente de valor o pre�o e a descri��o
SELECT descricao, val_unit FROM produto 
WHERE val_unit < 1.5 ORDER BY 2;

-- 5.4) Quais pedidos foram feitos pelos clientes de c�digo maior que 500? Mostre o
-- c�digo do cliente e o n�mero do pedido classifcado pelo c�digo do cliente de forma crescente
SELECT num_pedido, cod_clie FROM pedido 
WHERE cod_clie > 500 ORDER BY 2;
