-- Aula 04 - Laços de Repetição (LOOP, WHILE, FOR)
-- (28/08/2023)

----------------------------------------------------

-- Laços de repetição ( LOOP )

SET SERVEROUTPUT ON
DECLARE
    v_contador NUMBER(2) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
        v_contador := v_contador + 1;
        EXIT WHEN v_contador > 20;
    END LOOP;         
END;
/

--------------------------

-- Laços de repetição ( WHILE )

SET SERVEROUTPUT ON
DECLARE
    v_contador NUMBER(2) := 1;
BEGIN
    WHILE v_contador <= 20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
        v_contador := v_contador + 1;
    END LOOP;         
END;
/

--------------------------

-- Laços de repetição ( FOR )

SET SERVEROUTPUT ON
BEGIN
    FOR v_contador IN 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
    END LOOP;         
END;
/

--------------------------

-- Laços de repetição ( FOR REVERSE )

SET SERVEROUTPUT ON
BEGIN
    FOR v_contador IN REVERSE 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_contador);
    END LOOP;         
END;
/

----------------------------------------------------

-- EXERCÍCIOS

-- 1º) Montar um bloco de programação que realize o
-- processamento de uma tabuada qualquer, por
-- exemplo a tabuada do número 5.

-----( LOOP )-----

SET SERVEROUTPUT ON
DECLARE
    v_tabuada NUMBER(10) := &Tabuada;
    v_cont v_tabuada%TYPE := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_tabuada || ' X ' || v_cont || ' = ' || (v_tabuada * v_cont));
        v_cont := v_cont + 1;
        EXIT WHEN v_cont > 10;
    END LOOP;         
END;
/

-----( WHILE )-----

SET SERVEROUTPUT ON
DECLARE
    v_tabuada NUMBER(10) := &Tabuada;
    v_cont v_tabuada%TYPE := 0;
BEGIN
    WHILE v_cont <= 10 LOOP
         DBMS_OUTPUT.PUT_LINE(v_tabuada || ' X ' || v_cont || ' = ' || (v_tabuada * v_cont));
         v_cont := v_cont + 1;
    END LOOP;         
END;
/

------( FOR )------

SET SERVEROUTPUT ON
DECLARE
    v_tabuada NUMBER(10) := &Tabuada;
    v_cont v_tabuada%TYPE := 0;
BEGIN
    FOR v_cont IN 1..10 LOOP
         DBMS_OUTPUT.PUT_LINE(v_tabuada || ' X ' || v_cont || ' = ' || (v_tabuada * v_cont));
    END LOOP;         
END;
/

--------------------------

-- 2º) Em um intervalo numérico inteiro, informar
-- quantos números são pares e quantos são ímpares.

SET SERVEROUTPUT ON
DECLARE
    v_inicio NUMBER(3) := &Inicio;
    v_fim v_inicio%TYPE := &Fim;
    v_par v_inicio%TYPE := 0;
    v_impar v_inicio%TYPE := 0;
BEGIN
    FOR v_conta IN v_inicio..v_fim LOOP
        IF MOD(v_conta, 2) = 0 THEN
           v_par := v_par + 1;
        ELSE
           v_impar := v_impar + 1;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total de pares ' || v_par);
    DBMS_OUTPUT.PUT_LINE('Total de ímpares ' || v_impar);
END;
/

--------------------------

-- 3º) Exibir e média dos valores pares em um intervalo
-- numérico e soma dos ímpares.

SET SERVEROUTPUT ON
DECLARE
    v_inicio NUMBER(3) := &Inicio;
    v_fim v_inicio%TYPE := &Fim;
    v_par v_inicio%TYPE := 0;
    v_impar v_inicio%TYPE := 0;
    v_soma_impar v_inicio%TYPE := 0;
    v_media NUMBER(10,2);
BEGIN
    FOR v_conta IN v_inicio..v_fim LOOP
        IF MOD(v_conta, 2) = 0 THEN
            v_par := v_par + 1;
            v_media := v_media + v_conta;
        ELSE
            v_impar := v_impar + 1;
            v_soma_impar := v_soma_impar + v_conta;
        END IF;
    END LOOP;

    IF v_par > 0 THEN
        v_media := v_media / v_par;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Total de pares: ' || v_par);
    DBMS_OUTPUT.PUT_LINE('Média dos valores pares: ' || v_media);
    DBMS_OUTPUT.PUT_LINE('Soma dos valores ímpares: ' || v_soma_impar);
END;
/
