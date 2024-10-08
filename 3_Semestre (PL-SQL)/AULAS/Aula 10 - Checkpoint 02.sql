-- CHECKPOINT #2 - (09/10/23)

----------------------------------------------------------------

SET VERIFY OFF
SET SERVEROUTPUT ON

DROP TABLE ordem_servico CASCADE CONSTRAINTS;
DROP TABLE tecnico CASCADE CONSTRAINTS;
DROP TABLE ordem_tec CASCADE CONSTRAINTS;

-- CRIAR TABELAS

CREATE TABLE ordem_servico (
    id_os NUMBER(3) PRIMARY KEY,
    data_abertura DATE,
    vlr_por_hora NUMBER(8,2)
);

CREATE TABLE tecnico (
    id_tec NUMBER(3) PRIMARY KEY,
    nome_tec VARCHAR2(250)
);

CREATE TABLE ordem_tec (
    dt_fim DATE,
    dias_trabalhados NUMBER(3),
    fk_id_os NUMBER(3),
    fk_id_tec NUMBER(3),
    FOREIGN KEY (fk_id_os) REFERENCES ordem_servico(id_os),
    FOREIGN KEY (fk_id_tec) REFERENCES tecnico(id_tec)
);

----------------------------------------------------------------

-- CRIANDO PROGRAMAS

-- 1) Criar um bloco PLSQL para cadastrar um novo técnico, ordem de
-- serviço e a realização do serviço, caso o técnico, ou a Ordem de
-- Serviço ou ainda sua realização já exista, informar em tela qual
-- das informações já estão cadastradas.

DECLARE
    v_tec_id NUMBER(3);
    v_os_id NUMBER(3);
    v_count_tec NUMBER(1);
    v_count_os NUMBER(1);
    v_count_rel NUMBER(1);
BEGIN
    v_tec_id := 1;
    v_os_id := 1;

    SELECT COUNT(*) INTO v_count_tec FROM tecnico 
    WHERE id_tec = v_tec_id;

    SELECT COUNT(*) INTO v_count_os FROM ordem_servico 
    WHERE id_os = v_os_id;

    SELECT COUNT(*) INTO v_count_rel FROM ordem_tec 
    WHERE fk_id_tec = v_tec_id AND fk_id_os = v_os_id;

    IF v_count_tec > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Técnico já foi cadastrado.');
    ELSIF v_count_os > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ordem de Serviço já foi cadastrado.');
    ELSIF v_count_rel > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Relação entre técnico-ordem de serviço já foi cadastrada.');
    ELSE
        INSERT INTO tecnico (id_tec, nome_tec) 
            VALUES(v_tec_id, 'Vinicius');
        INSERT INTO ordem_servico (id_os, data_abertura, vlr_por_hora) 
            VALUES(v_os_id, SYSDATE, 50.00);
        INSERT INTO ordem_tec (dt_fim, dias_trabalhados, fk_id_os, fk_id_tec) 
             VALUES (SYSDATE, 5, v_os_id, v_tec_id);

        DBMS_OUTPUT.PUT_LINE('Cadastro realizado com sucesso.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Aconteceu um erro: ' || SQLERRM);
END;
/

----------------------------------------------------------------

-- 2-) Criar um bloco PLSQL para calcular e exibir o nome do técnico,
-- a OS(s) em que está alocado, o tempo que trabalhou, se ainda está na
-- realização do serviço seu salário hoje.

DECLARE
    v_tec_id NUMBER(3) := 2; 
    v_os_id NUMBER(3);
    v_os_data_abertura DATE;
    v_os_vlr_por_hora NUMBER(8, 2);
    v_tempo_trabalhado NUMBER(5, 2);
    v_salario NUMBER(10, 2);
    v_tempo_total NUMBER(5, 2);
BEGIN
    DECLARE
        v_nome_tec VARCHAR2(250);
    BEGIN
        SELECT nome_tec 
        INTO v_nome_tec 
        FROM tecnico 
        WHERE id_tec = v_tec_id;
        DBMS_OUTPUT.PUT_LINE('Nome do Técnico: ' || v_nome_tec);
    END;
   
    FOR os IN (SELECT ot.fk_id_os, os.data_abertura, os.vlr_por_hora
               FROM ordem_tec ot
               JOIN ordem_servico os ON ot.fk_id_os = os.id_os
               WHERE ot.fk_id_tec = v_tec_id)
    LOOP
        v_os_id := os.fk_id_os;
        v_os_data_abertura := os.data_abertura;
        v_os_vlr_por_hora := os.vlr_por_hora;
        
        v_tempo_trabalhado := 8; 
        v_salario := v_os_vlr_por_hora * v_tempo_trabalhado;
        v_tempo_total := v_tempo_total + v_tempo_trabalhado;
    
        DBMS_OUTPUT.PUT_LINE('Ordem de Serviço ID: ' || v_os_id);
        DBMS_OUTPUT.PUT_LINE('Data de Abertura: ' 
                             || TO_CHAR(v_os_data_abertura, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Tempo Trabalhado: ' || v_tempo_trabalhado || ' horas');
        DBMS_OUTPUT.PUT_LINE('Salário para esta OS: R$ ' 
                             || TO_CHAR(v_salario, '999999.99'));
        DBMS_OUTPUT.PUT_LINE('---');
    END LOOP;

    IF v_tempo_total < 40 THEN
        DBMS_OUTPUT.PUT_LINE('O técnico ainda está em atividade.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('O técnico completou seu trabalho para o dia.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado para o técnico com ID: ' || v_tec_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro inesperado: ' || SQLERRM);
END;
/

----------------------------------------------------------------

-- 3 ) Criar um bloco PLSQL para mostrar as Ordens de serviço com seus  
-- técnicos e o período que trabalharam nelas ou se ainda estão trabalhando nelas.

DECLARE
    v_os_id number(3);
    v_tec_id number(3);
    v_tempo_trabalhado number(5, 2);
    v_data_abertura date;
    v_data_fim date;
BEGIN
    FOR os IN (
        SELECT ot.fk_id_os, 
               ot.fk_id_tec, 
               ot.dt_fim, 
               ot.dias_trabalhados, 
               os.data_abertura
        FROM ordem_tec ot
        JOIN ordem_servico os ON ot.fk_id_os = os.id_os
    )
    LOOP
        BEGIN
            v_os_id := os.fk_id_os;
            v_tec_id := os.fk_id_tec;
            v_tempo_trabalhado := os.dias_trabalhados;
            v_data_abertura := os.data_abertura;
            v_data_fim := os.dt_fim;

            IF v_data_fim IS NULL THEN
                DBMS_OUTPUT.PUT_LINE('Ordem de Serviço ID: ' || v_os_id 
                                     || ' - Técnico ID: ' || v_tec_id);
                DBMS_OUTPUT.PUT_LINE('Data de Abertura: ' 
                                     || TO_CHAR(v_data_abertura, 'DD-MON-YYYY'));
                DBMS_OUTPUT.PUT_LINE('Ainda trabalhando nesta ordem de serviço por ' 
                                     || v_tempo_trabalhado || ' dias.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Ordem de Serviço ID: ' || v_os_id 
                                     || ' - Técnico ID: ' || v_tec_id);
                DBMS_OUTPUT.PUT_LINE('Data de Abertura: ' 
                                     || TO_CHAR(v_data_abertura, 'DD-MON-YYYY'));
                DBMS_OUTPUT.PUT_LINE('Trabalhado nesta ordem de serviço por ' 
                                     || v_tempo_trabalhado || ' dias.');
                DBMS_OUTPUT.PUT_LINE('Concluído em: ' || TO_CHAR(v_data_fim, 'DD-MON-YYYY'));
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        END;
    END LOOP;
END;
/
