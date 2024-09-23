-- Aula 07 - Cursores
-- (18/09/2023)

--------------------------

DROP TABLE funcionario CASCADE CONSTRAINTS;

CREATE TABLE funcionario (
    cd_fun NUMBER(2) PRIMARY KEY,
    nm_fun VARCHAR2(20), 
    salario NUMBER(10,2),
    dt_adm DATE
);

BEGIN
    INSERT INTO funcionario VALUES 
        (1, 'Marcel', 10000, '17-apr-2000');
    INSERT INTO funcionario VALUES 
        (2, 'Claudia', 16000, '02-oct-1998');
    INSERT INTO funcionario VALUES 
        (3, 'Joaquim', 5500, '10-jul-2010');
    INSERT INTO funcionario VALUES 
        (4, 'Valéria', 7300, '08-jun-2015');
COMMIT;
END;

--------------------------

-- 1- ) Incluir na tabela funcionário a coluna tempo de tipo 
-- numérico, atualizar esta coluna com o tempo em dias 
-- que cada funcionário está trabalhando na empresa, 
-- lembrando que sysdate retorna a data do sistema

ALTER TABLE funcionario ADD tempo NUMBER(5)

DECLARE
    CURSOR C_exibe IS SELECT * FROM funcionario;
BEGIN
    FOR V_exibe IN C_exibe LOOP
        UPDATE funcionario SET tempo = sysdate - v_exibe.dt_adm
        WHERE cd_fun = v_exibe.cd_fun;
    END LOOP;
END;

SELECT * FROM funcionario;

--------------------------

-- 2- ) Para os funcionários com tempo de serviço superior ou 
-- igual a 150 meses, adicionar 10% ao salário e para o 
-- restante 5%.

SET SERVEROUTPUT ON
DECLARE
    CURSOR C_exibe IS SELECT * FROM funcionario;
BEGIN
    FOR V_exibe IN C_exibe LOOP
    /*IF (v_exibe.tempo / 30) >= 150 THEN
          UPDATE funcionario 
          SET salario = salario * 1.1 
          WHERE cd_fun = v_exibe.cd_fun;
      ELSE
          UPDATE funcionario 
          SET salario = salario * 1.05 
          WHERE cd_fun = v_exibe.cd_fun;
      END IF;*/
      DBMS_OUTPUT.PUT_LINE(v_exibe.tempo / 30);
    END LOOP;
END;
/

--------------------------

DECLARE
    CURSOR C_exibe IS SELECT * FROM funcionario;
    n_meses number(5);
BEGIN
    FOR V_exibe IN C_exibe LOOP
        SELECT months_between(sysdate, dt_adm) INTO n_meses
        FROM funcionario WHERE cd_fun = v_exibe.cd_fun;

        IF n_meses >= 150 THEN
            UPDATE funcionario 
            SET salario = salario * 1.1 
            WHERE cd_fun = v_exibe.cd_fun;
        ELSE
            UPDATE funcionario 
            SET salario = salario * 1.05 
            WHERE cd_fun = v_exibe.cd_fun;
        END IF;
    END LOOP;
END;
/

SELECT * FROM funcionario;
