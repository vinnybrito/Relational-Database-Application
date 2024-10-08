-- Aula 03 - Instruções DML, DQL em blocos PL/SQL
-- (21/08/2023)

-- CHECKPOINT #1 - (04/09) - Individual ou em dupla

SET SERVEROUTPUT ON
SET VERIFY OFF

--------------------------

-- Criar tabela aluno

CREATE TABLE ALUNO (
    ra CHAR(9),
    nome VARCHAR2(50),
    CONSTRAINT aluno_pk PRIMARY KEY(ra)
);

--------------------------

-- Inserindo Dados dentro de um bloco

BEGIN
    INSERT INTO aluno (ra, nome) VALUES ('111222333', 'Antonio Alves');
    INSERT INTO aluno (ra, nome) VALUES ('222333444', 'Beatriz Bernardes');
    INSERT INTO aluno (ra, nome) VALUES ('333444555', 'Cláudio Cardoso');
END;

--------------------------

-- Realizar relatórios em PL/SQL - (SELECT)

SET SERVEROUTPUT ON
DECLARE 
    v_ra CHAR(9) := '333444555';
    v_nome VARCHAR2(50);
BEGIN
    SELECT nome INTO v_nome FROM aluno WHERE ra = v_ra;
    DBMS_OUTPUT.PUT_LINE('O nome do aluno é: ' || v_nome);
END;

--------------------------

-- Inserir informações em PL/SQL - (INSERT)

DECLARE 
    v_ra CHAR(9) := '444555666';
    v_nome VARCHAR2(50) := 'Daniela Dorneles';
BEGIN
    INSERT INTO aluno (ra,nome) VALUES (v_ra,v_nome);
END;

--------------------------

-- Atualizando informações na tabela - (UPDATE)

SET SERVEROUTPUT ON
DECLARE 
    V_RA CHAR(9) := '111222333';
    V_NOME VARCHAR2(50) := 'Antonio Rodrigues';
BEGIN
    UPDATE aluno SET nome = v_nome WHERE ra = v_ra;
END;

--------------------------

-- Deletar dados na tabela - (DELETE) 

SET SERVEROUTPUT ON
DECLARE 
    V_RA CHAR(9) := '444555666';
BEGIN
    DELETE FROM aluno WHERE ra = v_ra;
END;

-------------------------------------

-- EXERCÍCIO

-- 1º) Criar tabela produto e inserir dados.

DROP TABLE produto CASCADE CONSTRAINTS;

CREATE TABLE produto (
   id_pro NUMBER(3) PRIMARY KEY,
   ds_pro VARCHAR2(30) NOT NULL UNIQUE,
   pr_pro NUMBER(10,2) NOT NULL,
   qtd_pro NUMBER(10,2) NOT NULL
);

BEGIN
    INSERT INTO produto VALUES (1, 'Pneu', 350.56, 100);
    INSERT INTO produto VALUES (2, 'Multimidia', 2380.6, 5);
    INSERT INTO produto VALUES (3, 'Chaveiro', 12.4, 150);
    COMMIT;
END;

------------------

-- 1.1º) Criar um bloco PL/SQL para que o usuário possa selecionar
-- a quantidade de produtos que ele deseja, atravez do seu ID. Ao
-- selecionar a quantidade o programa deve atualizar na tabela o 
-- novo valor da quantidade e exibir na tela o resultado.

SET SERVEROUTPUT ON
DECLARE
    v_idpro NUMBER(3) := &cd_produto;
    v_compra NUMBER(10,2) := &qtd_compra;
    v_dspro VARCHAR2(30);
    v_prpro NUMBER(10,2);
    v_total NUMBER(12,2);
    v_qtdpro NUMBER(10,2);
BEGIN
    SELECT ds_pro, pr_pro, qtd_pro 
    INTO v_dspro, v_prpro, v_qtdpro
    FROM produto 
    WHERE id_pro = v_idpro;

    v_total := v_compra * v_prpro;

    UPDATE produto SET qtd_pro = qtd_pro - v_compra
    WHERE id_pro = v_idpro;

    DBMS_OUTPUT.PUT_LINE('Descrição do produto: ' || v_dspro);
    DBMS_OUTPUT.PUT_LINE('Preço do produto: ' || v_prpro);
    DBMS_OUTPUT.PUT_LINE('Qtd comprada: ' || v_compra);
    DBMS_OUTPUT.PUT_LINE('Total da compra - R$: '|| v_total);
END;
/

------------------

-- Escolher se vai ser feita a compra ou a venda do produto

SET SERVEROUTPUT ON
DECLARE
    v_idpro NUMBER(3) := &cd_produto;
    v_compra NUMBER(10,2) := &qtd_compra;
    v_opcao VARCHAR2(10) := UPPER('&compra_ou_venda');
    v_dspro VARCHAR2(30);
    v_prpro NUMBER(10,2);
    v_total NUMBER(12,2);
    v_qtdpro NUMBER(10,2);
BEGIN
    SELECT ds_pro, pr_pro, qtd_pro 
    INTO v_dspro, v_prpro, v_qtdpro
    FROM produto WHERE id_pro = v_idpro;

    IF v_opcao = 'COMPRA' THEN
	v_total := v_compra * v_prpro;
	
	UPDATE produto SET qtd_pro = qtd_pro - v_compra
        WHERE id_pro = v_idpro;

    	DBMS_OUTPUT.PUT_LINE('Descrição do produto: ' || v_dspro);
    	DBMS_OUTPUT.PUT_LINE('Preço do produto: ' || v_prpro);
    	DBMS_OUTPUT.PUT_LINE('Qtd comprada: ' || v_compra);
    	DBMS_OUTPUT.PUT_LINE('Total da compra - R$: '|| v_total);
	
    ELSIF v_opcao = 'VENDA' THEN
        v_total := v_prpro - 

    ELSE
	DBMS_OUTPUT.PUT_LINE('Opção Invalida');
    END IF;
END;
/
