-- Aula 06 - Cursores
-- (11/09/2023)

-- CHECKPOINT #2 - (02-10-23)

--------------------------

-- EXERCÍCIO

-- 1º) Criar a seguinte Tabela e inserir os respectivos dados:
-- funcionário

DROP TABLE funcionario CASCADE CONSTRAINTS;

CREATE TABLE funcionario (
    cd_fun NUMBER(10) PRIMARY KEY,
    nm_fun VARCHAR2(50),
    salario NUMBER(10,2),
    dt_adm DATE
);

BEGIN
    INSERT INTO funcionario VALUES
        (1, 'Marcel', 10000.00, '17-04-2000');
    INSERT INTO funcionario VALUES
        (2, 'Claudia', 16000.00, '12-10-1998');
    INSERT INTO funcionario VALUES
        (3, 'Joaquim', 5500.00, '10-07-2010');
    INSERT INTO funcionario VALUES
        (4, 'Valéria', 7300.00, '08-06-2015');
    COMMIT;
END;
/

--------------------------

-- 1.1) Criar um bloco PL usando cursores para mostrar o nome do
-- funcionário e seu salário. 

-- Sem a utilização de um cursor

DECLARE
     v_cd NUMBER(2) := &cd_fun;
     v_nome VARCHAR2(20);
     v_sal NUMBER(10,2);
BEGIN
     SELECT nm_fun, salario INTO v_nome, v_sal FROM funcionario
     WHERE cd_fun = v_cd;
        
     DBMS_OUTPUT.PUT_LINE(v_nome || ' - ' || v_sal);
END;
/

--------------------

-- Utilizando um cursor com ( LOOP )

DECLARE
    CURSOR c_exibe IS SELECT nm_fun, salario FROM funcionario;
    v_exibe c_exibe%ROWTYPE;
BEGIN
    OPEN c_exibe;
        LOOP
            FETCH c_exibe INTO v_exibe;
        EXIT WHEN c_exibe%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_exibe.nm_fun || 
                             ' -  Salário: ' || v_exibe.salario);
        END LOOP;
    CLOSE c_exibe;
END;
/

--------------------

-- Utilizando cursor com ( FOR )

DECLARE 
    CURSOR c_exibe IS SELECT nm_fun, salario FROM funcionario;
BEGIN
    FOR v_exibe IN c_exibe LOOP
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_exibe.nm_fun || 
                             ' -  Salário: ' || v_exibe.salario);
    END LOOP;
END;
/

--------------------------

-- 2º) - Incluir na tabela funcionário a coluna tempo de tipo
-- numérico, atualizar esta coluna com o tempo em dias
-- que cada funcionário está trabalhando na empresa,
-- lembrando que sysdate retorna a data do sistema;

ALTER TABLE funcionario ADD tempo NUMBER(10);

DECLARE
    CURSOR c_exibe IS SELECT * FROM funcionario;
BEGIN
    FOR v_exibe IN c_exibe LOOP
        UPDATE funcionario SET tempo = SYSDATE - v_exibe.dt_adm
        WHERE cd_fun = v_exibe.cd_fun;
    END LOOP;
END;
/

--------------------------

-- 3º) Para os funcionários com tempo de serviço superior ou
-- igual a 150 meses, adicionar 10% ao salário e para o
-- restante 5%.

DECLARE
    CURSOR C_exibe IS SELECT * FROM funcionario;
BEGIN
    FOR V_exibe IN C_exibe LOOP
    	IF (v_exibe.tempo / 30) >= 150 THEN
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
