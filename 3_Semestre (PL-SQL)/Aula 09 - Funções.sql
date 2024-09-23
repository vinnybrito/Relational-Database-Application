-- Aula 09 - Funções
-- (02/10/23)

------------------------------------------

SET SERVEROUTPUT ON
VERIFY OFF

CREATE OR REPLACE FUNCTION soma (p1 IN  NUMBER, p2 IN NUMBER)
    RETURN NUMBER
    IS
      total NUMBER(4);
BEGIN
    total := p1 + p2;
    RETURN total;
END;
/

SELECT soma(1,1) FROM dual;

SET SERVEROUTPUT ON
DECLARE
    nota1 NUMBER(3) := 10;
    nota2 nota1%TYPE := 10;
    resul nota1%TYPE;
BEGIN
    resul := soma(nota1, nota2);
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resul);
END;
/
   
------------------------------------------
   
-- Objetivo: criar uma função que calcule a média

DROP TABLE boletim CASCADE CONSTRAINT;

CREATE TABLE Boletim (
    Rm NUMBER(3) NOT NULL,
    Nome_Comp VARCHAR2(20) NOT NULL,
    C_Hora NUMBER(3) NOT NULL,
    Nota1 NUMBER(4,2) NOT NULL,
    Nota2 NUMBER(4,2) NOT NULL,
    Nota3 NUMBER(4,2) NOT NULL,
    Media NUMBER(4,2),
    Faltas NUMBER(3) NOT NULL,
    Situacao VARCHAR2(40)
);        

INSERT ALL
    INTO boletim VALUES (135, 'DB Application', 200, 10, 10, 10, null, 0, null)
    INTO boletim VALUES (135, 'IA', 180, 7.5, 7.5, 8.0, null, 170, null)
    INTO boletim VALUES (135, 'ChatBot', 180, 1.0, 2.5, 1.5, null, 18, null)
    INTO boletim VALUES (135, 'UX', 200, 2.5, 1.0, 1.5, null, 170, null)
    INTO boletim VALUES (135, 'Mobile', 200, 4.0, 5.0, 4.5, null, 20, null)
    SELECT * FROM dual;
COMMIT;  

CREATE OR REPLACE FUNCTION calcularMedia (Nota1 IN NUMBER, Nota2 IN NUMBER, Nota3 IN NUMBER)
    RETURN NUMBER
    IS
    total NUMBER(4);
BEGIN
    total := (Nota1 + Nota2 + Nota3) / 3;
    RETURN total;
END;

SELECT calcularMedia(10,9,8) FROM dual;

SET SERVEROUTPUT ON
DECLARE
    v_Nome_Comp VARCHAR2(20);
    nota1 NUMBER(4,2) := &Nota_1;
    nota2 nota1%TYPE := &Nota_2;
    nota3 nota1%TYPE := &Nota_3;
    v_Media nota1%TYPE; 
    resul nota1%TYPE;
BEGIN
    SELECT Nome_Comp INTO v_Nome_Comp FROM boletim 
    WHERE v_Nome_Comp := 'IA';

    resul := calcularMedia(nota1, nota2, nota3);
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resul);
END;
/
