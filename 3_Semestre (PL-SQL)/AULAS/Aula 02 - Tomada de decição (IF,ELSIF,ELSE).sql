-- Aula 02 - Tomada de decição (IF, ELSIF, ELSE) 
-- (14/08/2023)

--------------------------

-- EXERCÍCIOS

-- 1º) Criar um bloco PL/SQL para analisar a entrada de dados do 
-- sexo de um cliente. O bloco deverá receber o dado sobre o
-- sexo: para masculino - M ou m, para feminino -F ou f. 
-- Qualquer dado fora desta configuração deverá ser exibido 
-- 'Outros', para M ou m 'Masculino', para F ou f 'Feminino'.

SET SERVEROUTPUT ON
DECLARE
    v_sexo CHAR(1) := UPPER('&sexo'); 
BEGIN
    IF v_sexo = 'F' THEN
        DBMS_OUTPUT.PUT_LINE('Feminino');S
    ELSIF v_sexo = 'M' THEN
        DBMS_OUTPUT.PUT_LINE('Masculino');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Outro');
    END IF;
END;
/

------------ Ex2 -------------

-- 2º) Refaça o exercício 5 da aula anterior. Dessa vez, 
-- utilize as estruturas de decisão (IF, ELSIF, ELSE)

SET SERVEROUTPUT ON
DECLARE
    v_carro NUMBER(10,2) := 50000 * 0.8;
    v_presta v_carro%TYPE;
    v_opcao v_carro%TYPE := &quantas_prestacoes;
BEGIN
    IF v_opcao = 6 THEN
        v_presta := (v_carro * 1.1) / 6;
        DBMS_OUTPUT.PUT_LINE('Valor da prestação em 6x: '||v_presta);
    ELSIF v_opcao = 12 THEN
        v_presta := (v_carro * 1.15) / 12;
        DBMS_OUTPUT.PUT_LINE('Valor da prestação em 12x: '||v_presta);
    ELSIF v_opcao = 18 THEN
        v_presta := (v_carro * 1.2) / 18;
        DBMS_OUTPUT.PUT_LINE('Valor da prestação em 18x: '||v_presta);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Valor Prestação não encontrado!');
    END IF;                
END;
/

------------ Ex3 -------------

-- 3º) Criar um bloco PL/SQL para calcular a média da fiap.
-- Entrada das notas via teclado.

SET SERVEROUTPUT ON
DECLARE
    v_cp1 NUMBER(10,2) := &checkpoint_1;
    v_cp2 v_cp1%TYPE := &checkpoint_2;
    v_cp3 v_cp1%TYPE := &checkpoint_3;
    v_resultado v_cp1%TYPE;
BEGIN
    IF ((v_cp1 < v_cp2) AND (v_cp1 < v_cp3)) THEN
        v_resultado := ((v_cp2 + v_cp3) / 2);
        DBMS_OUTPUT.PUT_LINE('Média: ' || v_resultado);
    ELSIF ((v_cp2 < v_cp1) AND (v_cp2 < v_cp3)) THEN
        v_resultado := ((v_cp1 + v_cp3) / 2);
        DBMS_OUTPUT.PUT_LINE('Média: ' || v_resultado);
    ELSE
        v_resultado := ((v_cp1 + v_cp2) / 2);
        DBMS_OUTPUT.PUT_LINE('Média: ' || v_resultado);     
    END IF;
END;
/
