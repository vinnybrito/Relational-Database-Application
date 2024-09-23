-- Aula 08 - Exceptions
-- (25/09/2023)

-- Data da CP2 - (09/10/2023)

-----------------------------------------

-- EXCEPTIONS

-- Exception - Tratamento de erros 
-- pré definida

DECLARE
      ...
BEGIN	
      ...
EXCEPTION
    WHEN NOME_DA_EXCEÇÃO THEN
    RELAÇÃO_DE_COMANDOS;
    WHEN NOME_DA_EXCEÇÃO THEN
    RELAÇÃO_DE_COMANDOS;
    ...
END;
/

-----------------------------------------

-- EXEMPLO

DROP TABLE aluno CASCADE CONSTRAINTS;

CREATE TABLE aluno (
    ra NUMBER(1) PRIMARY KEY, 
    nome VARCHAR(20)
);

INSERT INTO aluno VALUES (1,'Marcel');
INSERT INTO aluno VALUES (2,'Adriana');
INSERT INTO aluno VALUES (3,'Samuel');
COMMIT;

SELECT * FROM aluno;

SET SERVEROUTPUT ON
BEGIN
    INSERT INTO aluno VALUES (1,'Marcel');
EXCEPTION
    WHEN dup_val_on_index THEN
    DBMS_OUTPUT.PUT_LINE('Operação inválida');
END;

-----------------------------------------

DECLARE
    V_RA ALUNO.RA%TYPE := 9;
    V_NOME ALUNO.NOME%TYPE;
BEGIN
    SELECT NOME INTO V_NOME FROM ALUNO WHERE RA = V_RA;
    DBMS_OUTPUT.PUT_LINE(V_RA ||' - '|| V_NOME);
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE ('Não sei de nada, se vira');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('Não há nenhum aluno com este RA');
    WHEN TOO_MANY_ROWS THEN
	    DBMS_OUTPUT.PUT_LINE ('Há mais de um aluno com este RA');
END;
/

-----------------------------------------

-- PERSONALIZADA

DECLARE
    NOME_DA_EXCEÇÃO EXCEPTION;
BEGIN
    ...
    IF ... THEN
	RAISE NOME_DA_EXCEÇÃO;
    END IF;
    ...
EXCEPTION
    WHEN NOME_DA_EXCEÇÃO THEN
    RELAÇÃO_DE_COMANDOS
END;
/

SELECT * FROM aluno;

DECLARE
    V_CONTA NUMBER(2);
    TURMA_CHEIA EXCEPTION;
BEGIN
    SELECT COUNT(RA) INTO V_CONTA FROM ALUNO;
    IF V_CONTA = 5 THEN 
	RAISE TURMA_CHEIA;
    ELSE 
	INSERT INTO ALUNO VALUES (6,'Giovanna');
    END IF;
EXCEPTION
    WHEN TURMA_CHEIA THEN
    DBMS_OUTPUT.PUT_LINE('Não foi possível incluir: turma cheia');
END;

-----------------------------------------

-- EXERCÍCIO

-- Criar as tabelas: Cliente, ContaCorrente, Movimentação para gerenciar as operações de uma CC, 
-- deverão existir dois tipos de CC, as básicas que não permitem saques maiores que o saldo e as especiais
-- que permitirão estes saques em até 50% do saldo naquele momento do saque.

-- Você deverá:
-- Criar as tabelas para funcionamento do processo - movimentação de CC
-- Criar os blocos de programação:
-- - Um para cadastro do cliente, sua conta.
-- - Um para cadastro da movimentação, créditos - C e débitos - D, sempre exibir 
--   O saldo após a movimentação.
-- - Um para saque, alertando se é possível ou não realizar o mesmo e exibir o saldo no momento.
-- - Não esqueça das exceptions

CREATE TABLE Cliente (
    cliente_id NUMBER PRIMARY KEY,
    nome VARCHAR2(50),
    cpf VARCHAR2(11) UNIQUE
);

CREATE TABLE ContaCorrente (
    conta_id NUMBER PRIMARY KEY,
    cliente_id NUMBER REFERENCES Cliente(cliente_id),
    tipo_conta VARCHAR2(10),
    saldo NUMBER DEFAULT 0,
    CONSTRAINT chk_tipo_conta CHECK (tipo_conta IN ('Básica', 'Especial'))
);

CREATE TABLE Movimentacao (
    movimentacao_id NUMBER PRIMARY KEY,
    conta_id NUMBER REFERENCES ContaCorrente(conta_id),
    tipo_movimentacao CHAR(1),
    valor NUMBER,
    data_movimentacao DATE DEFAULT SYSDATE,
    saldo_anterior NUMBER,
    saldo_atual NUMBER
);

---------------------------------------

DECLARE
    v_cliente_id NUMBER;
    v_conta_id NUMBER;
BEGIN
    INSERT INTO Cliente(cliente_id, nome, cpf) 
    VALUES (1, 'João', '12345678901');

    SELECT cliente_id 
    INTO v_cliente_id 
    FROM Cliente 
    WHERE cpf = '12345678901';
    
    INSERT INTO ContaCorrente(conta_id, cliente_id, tipo_conta) 
    VALUES (1, v_cliente_id, 'Básica');
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cadastro de cliente e conta realizado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Erro ao cadastrar cliente e conta: ' || SQLERRM);
END;
/

---------------------------------------

DECLARE
    v_conta_id NUMBER := 1;
    v_tipo_movimentacao CHAR(1) := 'C';
    v_valor NUMBER := 200;
    v_saldo_anterior NUMBER;
    v_saldo_atual NUMBER;
    v_tipo_conta VARCHAR2(10);
BEGIN
    SELECT tipo_conta, saldo 
    INTO v_tipo_conta, v_saldo_anterior 
    FROM ContaCorrente 
    WHERE conta_id = v_conta_id;

    IF v_tipo_movimentacao = 'C' THEN
        v_saldo_atual := v_saldo_anterior + v_valor;
    ELSIF v_tipo_movimentacao = 'D' THEN
        IF v_valor <= v_saldo_anterior OR (v_valor <= v_saldo_anterior * 1.5 AND v_tipo_conta = 'Especial') THEN
            v_saldo_atual := v_saldo_anterior - v_valor;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Saldo insuficiente para o débito.');
            RETURN;
        END IF;
     END IF;

     INSERT INTO Movimentacao(movimentacao_id, conta_id, tipo_movimentacao, valor, saldo_anterior, saldo_atual)
     VALUES (1, v_conta_id, v_tipo_movimentacao, v_valor, v_saldo_anterior, v_saldo_atual);
     UPDATE ContaCorrente SET saldo = v_saldo_atual WHERE conta_id = v_conta_id;
     COMMIT;

     DBMS_OUTPUT.PUT_LINE('Movimentação registrada com sucesso.');
EXCEPTION
     WHEN OTHERS THEN
     ROLLBACK;
     DBMS_OUTPUT.PUT_LINE('Erro ao registrar movimentação: ' || SQLERRM);
END;
/

---------------------------------------

DECLARE
    v_conta_id NUMBER := 1;
    v_valor NUMBER := 100;
    v_saldo_atual NUMBER;
    v_tipo_conta VARCHAR2(10);
BEGIN
    SELECT tipo_conta, saldo 
    INTO v_tipo_conta, v_saldo_atual 
    FROM ContaCorrente 
    WHERE conta_id = v_conta_id;

    IF v_valor <= v_saldo_atual OR (v_valor <= v_saldo_atual * 1.5 AND v_tipo_conta = 'Especial') THEN
        v_saldo_atual := v_saldo_atual - v_valor;
                
        UPDATE ContaCorrente 
        SET saldo = v_saldo_atual 
        WHERE conta_id = v_conta_id;
        COMMIT;
                
        DBMS_OUTPUT.PUT_LINE('Saque de ' || v_valor || ' realizado com sucesso. Saldo atual: ' || v_saldo_atual);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Saldo insuficiente para o saque.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Erro ao realizar saque: ' || SQLERRM);
END;
/
