-- Aula 12 - Funcoes Numuricas e Agrupamento
-- (03-Mai-2023)

-- Funcoes Numuricas Simples:
-- COUNT, SUM, AVG, ROUND, TRUNC, MAX, MIN;

-- Tabelas da Atividade 04
SELECT * FROM cliente;
SELECT * FROM vendedor;
SELECT * FROM produto;
SELECT * FROM pedido;
SELECT * FROM item_pedido;

----------------- COUNT -----------------

-- Contador de linhas
-- Exemplo: COUNT(coluna) ou COUNT(*);

-- Quantos clientes existem por estado?
SELECT uf FROM cliente ORDER BY 1;

SELECT COUNT(*) FROM produto;

-- Quantos clientes existem na tabela cliente?
SELECT COUNT(cod_clie), COUNT(cep) FROM cliente;

----------------- SUM -----------------

-- Somatoria de valores em colunas
-- Exemplo: SUM(coluna);

-- Qual o custo da folha de pagamento?
SELECT SUM(salario_fixo) FROM vendedor;

----------------- AVG -----------------

-- Calculo da media dos valores em colunas
-- Exemplo: AVG(coluna);

-- Qual a media salarial dos vendedores?
SELECT ROUND(AVG(salario_fixo),2) FROM vendedor;

------------ ROUND & TRUNC ------------

ROUND - Arredondamento, 1 posicao apos limite >= 5, + 1 a esquerda;
TRUNC - Despreza casas decimais, sem arredondamento;

SELECT 
    salario_fixo / 1.3, 
    ROUND(salario_fixo / 1.3,2),
    TRUNC(salario_fixo/ 1.3,2) 
FROM 
    Vendedor;

----------------- MAX -----------------

-- Maior valor na coluna
-- Exemplo: MAX(coluna);

-- Qual o maior sal�rio cadastrado na tabela vendedor?

SELECT MAX(salario_fixo) FROM vendedor;

SELECT salario_fixo SELECT vendedor ORDER BY 1 DESC
SELECT MAX(nome_clie) FROM cliente;

----------------- MIN -----------------

-- Menor valor na coluna
-- Exemplo: MIN(coluna);

-- Qual o menor sal�rio cadastrado na tabela vendedor?
SELECT MIN(salario_fixo) FROM vendedor;

SELECT salario_fixo FROM vendedor ORDER BY 1;

---------------------------
-- EXEMPLOS
---------------------------

-- Crie um relatorio que mostre o maior e o menor preco existente na tabela produto
SELECT MAX(val_unit) "Maior Preco", MIN(val_unit) "Menor Preco" FROM produto;

-- Crie um relatorio que mostre quantos clientes moram em Sao Paulo.
SELECT COUNT(cod_clie) "Total de clientes em SP" FROM cliente 
WHERE uf = 'SP';

SELECT uf FROM cliente 
WHERE uf = 'SP';

-- Crie um relat�rio que exiba a quantidade de pedidos do cliente 720.
SELECT COUNT(num_pedido) "Total de pedidos" FROM pedido
WHERE cod_clie = 720;

-- Qual a m�dia salarial dos vendedore de comiss�o A?
SELECT AVG(salario_fixo) FROM vendedor 
WHERE comissao = 'A';

-- Qual � o custo da folha de pagamento dos vendedores de comiss�o C?
SELECT SUM(salario_fixo) FROM vendedor 
WHERE comissao = 'C';

-- Exiba o nome e sal�rio do vendedor que tem o maior sal�rio cadastrado na tabela
-- vendedor.
SELECT nome_ven, MAX(salario_fixo) FROM vendedor;

---------------------------
-- Solu��o em duas partes
---------------------------

-- 1) Sele��o que exibe a sa�da de dados
SELECT nome_ven, salario_fixo FROM vendedor;

-- 2) Filtro de exibi��o
SELECT MAX(salario_fixo) FROM vendedor;

-- 3) Juntar as instru��es
SELECT nome_ven, salario_fixo FROM vendedor
WHERE salario_fixo IN (SELECT MAX(salario_fixo) FROM vendedor);

-- Exiba o nome do vendedor e seu sal�rio, desde que ele ganhe acima da m�dia.
    -- A) Sele��o que exibe a sa�da de dados;
    -- B) Filtro de exibi��o;
    -- C) Juntar as instru��es;

SELECT 
    nome_ven, 
    salario_fixo 
FROM 
    Vendedor
WHERE 
    salario_fixo > (SELECT AVG(salario_fixo) FROM vendedor);

----------------------------------
-- FUNÇÕES DE GRUPO
----------------------------------

-- Fun��es de Grupo - Analisam linhas e retornam um resultado apenas

----------------- GROUP BY -----------------

-- Quantos clientes existem por UF?
SELECT uf, COUNT(cod_clie) FROM cliente GROUP BY uf ORDER BY 1;

-- Quantos vendedores existem por comiss�o?
SELECT comissao, COUNT(cod_ven) FROM vendedor GROUP BY comissao;

-- Quantos pedidos cada cliente possui?
SELECT cod_clie, COUNT(num_pedido) FROM pedido GROUP BY cod_clie ORDER BY 1;

SELECT * FROM pedido 
WHERE cod_clie = 260;

-- Quantos produtos existem por pedido?
SELECT num_pedido, COUNT(cod_prod) FROM item_pedido
GROUP BY num_pedido ORDER BY 1;

----------------- HAVING -----------------

-- Quais clientes possuem mais de 1 pedido?
-- Condicao usada na funcao count having condicao
SELECT 
    cod_clie, 
    COUNT(num_pedido) 
FROM 
    pedido 
GROUP BY 
    cod_clie
HAVING COUNT(num_pedido) > 1 ORDER BY 1;
