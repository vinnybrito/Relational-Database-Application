-- Aula 08 - Construindo relatórios, comandos
-- (12-Abr-2023)

-- DQL: Data Query Language
-- Exibindo o conteúdo de uma tabela, todas as linhas e colunas

-- Sintaxe básica: 
SELECT * FROM nome_tabela;

SELECT = seleção
* = Todas as colunas
FROM = origem dos dados
nome_tabela = tabela destino do relatório

------------------------------------
-- EXEMPLOS: 
------------------------------------

-- 1) Exibir o conteúdo da tabela cliente
SELECT * FROM cliente;

-- 1.1) Mostre o conteúdo da tabela vendedor.
SELECT * FROM vendedor;

-- 1.2) Mostre o conteúdo da tabela que possui os produtos e seus pedidos.
SELECT * FROM item_pedido;

------------------------------------

-- 2) Criando um relatório com colunas específicas
-- Sintaxe: 
SELECT nome_col1, nome_col2 FROM nome_tabela;
--nome_col = nome da coluna a ser exibida

-- Mostrar o nome do cliente e o estado onde ele mora
SELECT nome_clie, uf FROM cliente;

-- 2.1) Exiba o nome do vendedor e seu salário
SELECT nome_ven, salario_fixo FROM vendedor;

-- 2.2) Mostre o nome do produto e seu preço
SELECT descricao, val_unit FROM produto;

------------------------------------

-- 3) Classificando relatórios
-- Sitaxe: select * from tabela order by nome_col asc (default) - crescente
-- Sitaxe: select * from tabela order by nome_col desc - decrescente

SELECT nome_clie, uf FROM cliente ORDER BY nome_clie ASC; -- (opcional)
SELECT nome_clie, uf FROM cliente ORDER BY 1 ASC; -- (opcional)
SELECT nome_clie, uf FROM cliente ORDER BY 1 DESC;
SELECT uf, nome_clie FROM cliente ORDER BY 1,2;
SELECT uf, nome_clie FROM cliente ORDER BY 1,2 DESC;

-- 3.1) Criar um relatório que mostre os pedidos organizados por número (crescente), 
-- cliente e vendedor decrescente
SELECT * FROM pedido ORDER BY 1, 3 DESC, 4 DESC;

-- 3.2) Mostrar em ordem decrescente de salário os dados dos vendedores
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
        Aritméticos: + - * / ()
        Relacionais : > >= < <= = <> ou !=
        Lógicos: AND, OR, NOT
        BD: BETWEEN, IN, LIKE

-- 5.1) Crie um relatório que mostre qual será o salário do vendedor com um aumento de 10%
SELECT salario_fixo "sal atual", salario_fixo * 1.1 "Sal Reaj 10%" FROM vendedor;

-- 5.2) Crie um relatório que exiba os clientes com nome e uf que morem no estado de SP
SELECT nome_clie, uf  FROM cliente 
WHERE upper(uf) = 'SP';

-- 5.3) Quais produtos custam abaixo de R$1,50? mostre em ordem crescente de valor o preço e a descrição
SELECT descricao, val_unit FROM produto 
WHERE val_unit < 1.5 ORDER BY 2;

-- 5.4) Quais pedidos foram feitos pelos clientes de código maior que 500? Mostre o
-- código do cliente e o número do pedido classifcado pelo código do cliente de forma crescente
SELECT num_pedido, cod_clie FROM pedido 
WHERE cod_clie > 500 ORDER BY 2;
