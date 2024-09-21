-- Aula 02 - DML - Linguagem de Manipula��o de Dados
-- (15-Fev-2023)

-- Cria��o das tabelas: n_fiscal e produto

CREATE TABLE n_fiscal (
    n_nf NUMBER(5) PRIMARY KEY,
    dt_nf DATE NOT NULL,
    total_nf NUMBER(10,2)
);

SELECT constraint_name FROM user_constraints 
WHERE table_name = 'N_FISCAL';

DESC n_fiscal;

CREATE TABLE produto (
    cd_pro NUMBER(5) CONSTRAINT prod_cd_pk PRIMARY KEY,
    nm_prod VARCHAR2(30) CONSTRAINT prod_mn_nn NOT NULL
                    CONSTRAINT prod_nm_uk UNIQUE,
    preco NUMBER(10,2)
);

SELECT constraint_name FROM user_constraints 
WHERE table_name = 'PRODUTO';

CREATE TABLE tem (
    fk_nota NUMBER(5) CONSTRAINT tem_nf_fk REFERENCES n_fiscal,
    fk_prod NUMBER(5) CONSTRAINT tem_prod_fk REFERENCES produto
);

------------------------------------

DML - Inserindo dados
Comando DML - Data Manipulation Language

-- Sintaxe::
INSERT INTO nome_tabela VALUES (valor1, valor2,...., valorN);

-- Obs: campos: CHAR, VARCHAR ou VARCHAR2 e DATE precisam de ap�strofe

-- Exemplo 1
-- Conhecendo ou visualizando a estrutura

DESC n_fiscal;

-- Inserindo uma linha
INSERT INTO n_fiscal VALUES (1,'10-Jan-00',5000);
INSERT INTO n_fiscal VALUES (2,'10-Dez-00',5000);

-- Verificando a inser��o
SELECT * FROM n_fiscal;

-- Descobrindo o padr�o da data
SELECT sysdate FROM dual;

-- Gravando dados fisicamente
COMMIT;
