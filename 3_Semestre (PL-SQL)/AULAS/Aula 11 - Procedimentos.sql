-- Aula 11 - Procedures
-- (16/10/2023)

------------------------------------------

-- Datas de Provas e atividades

-- CP3 - (06/11/2023)
-- GS - (21/11 a 01/12)
-- DP - (21/11 a 01/12)
-- Sub - (04/12 a 08/12)

------------------------------------------

CREATE OR REPLACE PROCEDURE nome_procedure
(argumento1 IN | OUT |IN OUT tipo_de_dados,
argumento2 IN | OUT |IN OUT tipo_de_dados,
...
argumentoN IN | OUT |IN OUT tipo_de_dados) IS | AS
variáveis locais, constantes, ...
BEGIN
...
END nome_procedure;

IN (padrão): Passa um valor do ambiente chamador para procedure e este
valor não pode ser alterado dentro dela (passagem de parâmetro por valor).

OUT: Passa um valor da procedure para o ambiente chamador (passagem de
parâmetro por referência).

IN OUT: Passa um valor do ambiente chamador para a procedure. Esse valor
pode ser alterado dentro da procedure e retornar com o valor atualizado para
o ambiente chamador (passagem de parâmetro por referência).
Nota: As palavras-chave IS ou AS (após a declaração dos parâmetros) podem ser
utilizadas, pois nesse contexto são equivalentes.

------------------------------------------

EXEMPLO:

DROP TABLE aluno CASCADE CONSTRAINTS;

CREATE TABLE aluno ( 
    ra char(2) primary key,
    nome varchar(20)
);

INSERT INTO aluno VALUES('1','Marcel');
INSERT INTO aluno VALUES('2','Silmara');
COMMIT;

SELECT * FROM aluno;

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE proc_nome_aluno (P_RA IN CHAR) 
    IS
      v_nome VARCHAR2(50);
BEGIN
    SELECT nome INTO v_nome FROM aluno
    WHERE ra = P_RA;

    DBMS_OUTPUT.PUT_LINE(v_nome);
END proc_nome_aluno;

Chamada, execução:
EXEC proc_nome_aluno(1);


------------------------------------------

-- EXERCÍCIO:

-- 1-) Criar um bloco de programação que permita a entrada do código do produto
-- para compra, esse código deverá verificar se o produto existe através de uma
-- ou mais exceções, após a validação da existÊncia do produto permitir a 
-- entrada da quantidade a ser comprada, tb será necessário verificar se a 
-- quantidade solicitada existe, use a lógica para isso,  para realizar a baixa 
-- de estoque crie uma função que calcule esta baixa e o custo da venda, crie 
-- um procedimento para mostrar em tela o código do produto, sua descrição, 
-- preço unitário, quantidade comprada e o valor da venda.
-- Criar uma tabela de nome produto, alimentar com 10 linhas de dados.

SET VERIFY OFF

DROP TABLE produto CASCADE CONSTRAINTS;
CREATE TABLE produto (
    cd_prod number(3) primary key,
    ds_prod varchar(25) not null unique,
    qtd_prod number(10,2),
    pr_prod number(10,2) not null
);

BEGIN
    INSERT INTO produto VALUES(1,'Pneu',100,500);
    INSERT INTO produto VALUES(2,'Pasta de dente',1000,12);
    INSERT INTO produto VALUES(3,'Capa de chuva',2,15.50);
    COMMIT;
END;


CREATE OR REPLACE cal_compra (p_qtd IN NUMBER)
IS
    calcula NUMBER(10,2);
BEGIN
    calcula := 
   
DECLARE
    v_compra produto.qtd_prod%type := &qtd;
    total produto.pr_prod%type;
    v_qtd produto.qtd_prod%type;
    v_ds produto.ds_prod%type;
BEGIN
    SELECT ds_prod, qtd_prod into v_ds, v_qtd FROM produto
    WHERE cd_prod = &codigo;

    IF v_qtd < v_compra THEN
        DBMS_OUTPUT.PUT_LINE('Estoque indisponível');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Chama função de cálculo');
    END if;
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Código inexistente');
END;
/
