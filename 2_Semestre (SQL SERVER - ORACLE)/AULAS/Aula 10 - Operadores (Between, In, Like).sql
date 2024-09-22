-- Aula 09 - Operadores (Between, In, Like)
-- (19-Abr-2023)

-- 5.5) Crie um relat�rio que exiba o c�digo do cliente e seu nome, desde que
-- estejam no intervalo de c�digo com in�cio em 180 at� 720 (inclusive)
SELECT cod_clie, nome_clie FROM cliente WHERE cod_clie >= 180 
AND cod_clie <= 720 ORDER BY 1;

-- 5.6) Crie um relat�rio que exiba o c�digo do cliente e seu nome, desde que
-- estejam no intervalo de c�digo com in�cio em 180 at� 720
SELECT cod_clie, nome_clie FROM cliente WHERE cod_clie > 180 
AND cod_clie < 720 ORDER BY 1;

-- 5.7) Crie um relat�rio que exiba o nome do cliente, desde que
-- estejam no intervalo de B at� F (inclusive)
SELECT nome_clie FROM cliente WHERE UPPER(nome_clie) >= 'B' 
AND UPPER(nome_clie) <= 'G' ORDER BY 1;

-- 5.8) Quem s�o os vendedores com sal�rio superior a R$2.000,00, que perten�am a 
-- comiss�o A ou C e que seu c�digo esteja no intervalo de 500 at� 800

SELECT * FROM vendedor 
WHERE salario_fixo > 2000;

SELECT * FROM vendedor WHERE salario_fixo > 2000 
AND comissao != 'B';

SELECT * FROM vendedor WHERE salario_fixo > 2000 
AND comissao != 'B' 
AND cod_ven > 500 
AND cod_ven < 800;

SELECT * FROM vendedor WHERE salario_fixo > 2000 
AND (comissao = 'A' OR comissao = 'C') 
AND cod_ven > 500 
AND cod_ven < 800;

------------------------------------

OPERADORES DE BANCO DE DADOS: (BETWEEN, IN, LIKE)

------------------- BETWEEN -------------------

BETWEEN (intervalo sequencial) -> coluna1 BETWEEN valor inicial AND valor final

-- Exemplo:
-- Usando operador tradicional: 	
                    SELECT cod_clie, nome_clie FROM cliente
                    WHERE cod_clie >= 180 AND cod_clie <= 720 ORDER BY 1;

-- Usando operador do Banco de Dados: 	        
                    SELECT cod_clie, nome_clie FROM cliente
                    WHERE cod_clie BETWEEN 180 AND 720 ORDER BY 1;

-- Usando o operador NOT: 
-- coluna1 not between valor inicial and valor final
                    SELECT cod_clie, nome_clie FROM cliente
                    WHERE cod_clie NOT BETWEEN 180 AND 720 ORDER BY 1;

---------------------- IN ----------------------
    
-- IN(list) (igual a uma lista) -> coluna1 in(valor1,...., valorN)
-- Exemplo: 

-- Usando operador tradicional:
          SELECT nome_clie, uf FROM cliente
          WHERE uf = 'SP' OR uf = 'RJ' OR uf = 'MG' ORDER BY uf;

-- Usando operador bd:
          SELECT nome_clie, uf FROM cliente
          WHERE uf IN('SP','RJ','MG') ORDER BY uf;

-- Usando o operador not: not in(list)
          SELECT nome_clie, uf FROM cliente
          WHERE uf NOT IN('SP','RJ','MG') ORDER BY uf;

--------------------- LIKE ---------------------
        
LIKE - Igual a posi��o ou igual a posi��es - > coluna LIKE 'op��o'
% = qualquer quantidade, qualquer posi��o
_ = posi��o e quantidade especifica


-- Nomes que tenham a letra 'a'
SELECT nome_clie FROM cliente 
WHERE UPPER(nome_clie) LIKE '%A%';

-- Nomes com a letra 'o'
SELECT nome_clie FROM cliente 
WHERE UPPER(nome_clie) LIKE '%O%';

-- Nomes que n�o iniciam com 'M' e 'R'
SELECT nome_clie FROM cliente 
WHERE UPPER(nome_clie) NOT LIKE 'M%' AND UPPER(nome_clie) NOT LIKE 'R%';

-- Nomes que a pen�ltima letra � a letra 'i'
SELECT nome_clie FROM cliente 
WHERE UPPER(nome_clie) LIKE '%I_';

-- Nomes com as letras 'a' ou 's'
SELECT nome_clie FROM cliente 
WHERE UPPER(nome_clie) LIKE '%A%' AND UPPER(nome_clie) NOT LIKE '%S%';

-- Nomes com as letras 'a' e 's'
SELECT nome_clie FROM cliente 
WHERE UPPER(nome_clie) LIKE '%A%' AND UPPER(nome_clie) LIKE '%S%';
