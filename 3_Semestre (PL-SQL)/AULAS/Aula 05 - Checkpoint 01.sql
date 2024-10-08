-- Aula 05 - CHECKPOINT #1
-- (04/09/2023)

--------------------------

-- EXERCÍCIO 1 - 4 PONTOS

-- 1º) Suponha que você está programando um módulo contador de cédulas para
-- caixas eletrônicos. Escreva um programa que informa com quantas cédulas 
-- de Real podemos representar um dado valor. 

-- EXEMPLO DE RESPOSTA: R$ 218 = 2 cédulas de 100, 1 cédula de 10, 1 cédula de 5,
-- 1 cédula de 2 e 1 cédula de 1. 

-- Procure minimizar o número de cédulas usadas. Desconsidere valores com
-- centavos, e suponha que a máquina sempre tem disponíveis as cédulas necessárias.

SET SERVEROUTPUT ON
DECLARE
    v_valor_real NUMBER := &v_valor_real;
    v_quant_100 v_valor_real%TYPE := 0;
    v_quant_50 v_valor_real%TYPE := 0;
    v_quant_20 v_valor_real%TYPE := 0;
    v_quant_10 v_valor_real%TYPE := 0;
    v_quant_5 v_valor_real%TYPE := 0;
    v_quant_2 v_valor_real%TYPE := 0;
    v_quant_1 v_valor_real%TYPE := 0;
BEGIN
    WHILE v_valor_real > 0 LOOP
        IF v_valor_real >= 100 Then
            v_quant_100 := v_quant_100 + 1;
            v_valor_real := v_valor_real - 100;
        elsif v_valor_real >= 50 then
            v_quant_50 := v_quant_50 + 1;
            v_valor_real := v_valor_real - 50;
        ELSIF v_valor_real >= 20 Then
            v_quant_20 := v_quant_20 + 1;
            v_valor_real := v_valor_real - 20;
        ELSIF v_valor_real >= 10 Then
            v_quant_10 := v_quant_10 + 1;
            v_valor_real := v_valor_real - 10;
        ELSIF v_valor_real >= 5 Then
            v_quant_5 := v_quant_5 + 1;
            v_valor_real := v_valor_real - 5;
        ELSIF v_valor_real >= 2 Then
            v_quant_2 := v_quant_2 + 1;
            v_valor_real := v_valor_real - 2;
        ELSE
            v_quant_1 := v_quant_1 + 1;
            v_valor_real := v_valor_real - 1;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('R$' || v_valor_real || ' = ');

    IF v_quant_100 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_100 || ' de R$ 100');
    END IF;
    IF v_quant_50 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_50 || ' de R$ 50');
    END IF;
    IF v_quant_20 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_20 || ' de R$ 20');
    END IF;
    IF v_quant_10 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_10 || ' de R$ 10');
    END IF;
    IF v_quant_5 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_5 || ' de R$ 5');
    END IF;
    IF v_quant_2 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_2 || ' de R$ 2');
    END IF;
    IF v_quant_1 > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_quant_1 || ' de R$ 1');
    END IF;
END;
/

--------------------------

-- EXERCÍCIO 2 - 6 PONTOS

-- 2º) Zeca está organizando um bolão de futebol. Segundo suas regras, os apostadores informam o
-- placar do jogo e ganham 10 pontos se acertarem o vencedor ou se acertarem que foi empate, e 
-- ganham mais 5 pontos para o placar de cada time que acertarem. A tabela a seguir dá um exemplo,
-- considerando que o placar real foi 3x2:

-- Criar a tabela apostador e inserir os dados da tabela

-- Criar um bloco que calcula a pontuação dos apostadores, entrada de dados:
-- Placar do jogo e código do apostador, atualizar a coluna pontos da tabela
-- apostador via bloco de programação.

DROP TABLE apostador;

CREATE TABLE apostador (
    Id_apostador NUMBER(10) PRIMARY KEY,
    Nome_apostador VARCHAR2(50),
    Gols_time_1 NUMBER(3),
    Gols_time_2 NUMBER(3),
    Pontos NUMBER(3)
);

SELECT * FROM apostador;

-- Inserir os dados da tabela

DECLARE
BEGIN
    INSERT INTO apostador (Id_apostador, Nome_apostador, Gols_time_1, Gols_time_2, Pontos) 
	VALUES (1, 'Marcel', 0, 1, NULL);
    INSERT INTO apostador (Id_apostador, Nome_apostador, Gols_time_1, Gols_time_2, Pontos) 
	VALUES (2, 'Rafael', 2, 0, NULL);
    INSERT INTO apostador (Id_apostador, Nome_apostador, Gols_time_1, Gols_time_2, Pontos) 
	VALUES (3, 'Denis', 1, 1, NULL);
    INSERT INTO apostador (Id_apostador, Nome_apostador, Gols_time_1, Gols_time_2, Pontos) 
	VALUES (4, 'Vanessa', 3, 2, NULL);
    COMMIT;
END;


DECLARE
    v_apostador_id NUMBER(10);
    v_time_1_goals NUMBER(3);
    v_time_2_goals NUMBER(3);
    v_pontuacao NUMBER(3);
BEGIN
    v_apostador_id := 1;
    v_time_1_goals := 1; 
    v_time_2_goals := 2; 

    v_pontuacao := 0;
    SELECT Pontos INTO v_pontuacao FROM apostador WHERE Id_apostador = v_apostador_id;
    
    IF v_time_1_goals = v_pontuacao THEN
        v_pontuacao := 3;
    ELSIF v_time_1_goals - v_time_2_goals = v_pontuacao THEN
        v_pontuacao := 2;
    ELSIF (v_time_1_goals > v_time_2_goals AND v_time_1_goals > v_pontuacao) OR (v_time_1_goals < v_time_2_goals AND v_time_1_goals < v_pontuacao) THEN
        v_pontuacao := 1;
    ELSE
        v_pontuacao := 0;
    END IF;
    
    UPDATE apostador SET Pontos = v_pontuacao WHERE Id_apostador = v_apostador_id;
    COMMIT;
END;

SELECT * FROM apostador;
