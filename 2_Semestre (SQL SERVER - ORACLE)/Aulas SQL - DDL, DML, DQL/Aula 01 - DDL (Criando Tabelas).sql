Introdução a linguagem SQL

DDL - Linguagem de definição de dados - Estrutura
Criando tabelas

-- Sintaxe:
    CREATE TABLE nome_tabela (
        nome_coluna1 tipo_dados(tamanho) [regra],
        ......,
        nome_colunaN tipo_dados(tamanho) [regra]
    );

Tipo de dados:   CHAR(n), campo alfanumérico de tamanho fixo
                            VARCHAR(n), campo alfanumérico de tamanho variavel
                            NUMBER(x,y), campo numérico inteiro ou real
                            DATE, campo tipo data
                            
-- Valores numéricos
n = Tamanho
x = Parte inteira
y = Parte real, casas decimais

-- Regras/Constraints
Pk - PRIMARY KEY, campo unico, preenchimento obrigatório, relacionamento
FK - FOREIGN KEY, relacionamento lado n da cardinalidade, recebe dados previamente cadastrados na Pk
Nn - NOT NULL, campo de preenchimento obrigatorio
Uk - UNIQUE, campo com restriçao a dados repetidos
Ck - CHECK, campo com lista de dados para validação

------------------------------------

EXEMPLIFICANDO

-- 1-) Criando uma tabela sem regras:

CREATE TABLE cargo (
    cd_cargo NUMBER(3),
    nm_cargo VARCHAR2(25),
    salario NUMBER(8,2)
);

-- Visualizando a estrutura de uma tabela
-- Exemplo: DESC nome_tabela
DESC cargo;

-- Deletando uma tabela
-- Exemplo: DROP TABLE nome_tabela
DROP TABLE cargo;

------------------------------------

-- 2-) Criando uma tabela com regras, sem personalização:

CREATE TABLE cargo (
    cd_cargo NUMBER(3) PRIMARY KEY,
    nm_cargo VARCHAR2(25) NOT NULL UNIQUE,
    salario NUMBER(8,2)
);

DESC cargo;

-- Visualizando constraints
SELECT constraint_name, constraint_type FROM user_constraints
WHERE table_name = 'CARGO';

------------------------------------

-- 3) Criando uma tabela com regras, com personalização:

DROP TABLE cargo;

CREATE TABLE cargo (
    cd_cargo NUMBER(3) CONSTRAINT cargo_cd_pk PRIMARY KEY,
    nm_cargo VARCHAR2(25) CONSTRAINT cargo_nome_nn NOT NULL 
                                                    CONSTRAINT cargo_nome_uk UNIQUE,
    salario NUMBER(8,2)
);

DESC cargo;

-- Visualizando constraints
SELECT constraint_name, constraint_type FROM user_constraints
WHERE table_name = 'CARGO';

------------------------------------

Criando o Relacionamento

( 1 - 1 ) - Pk + FK_Uk
( 1 - N ) - Pk + FK
( N - N ) - Não existe em código sql

------------------------------------

CREATE TABLE funcionario (
    cd_fun NUMBER(3) CONSTRAINT fun_cd_pk PRIMARY KEY,
    nm_fun VARCHAR2(30) CONSTRAINT fun_nm_nn NOT NULL,
    dt_adm DATE CONSTRAINT fun_dt_nn NOT NULL,
    uf_fun CHAR(2) CONSTRAINT fun_uf_nn NOT NULL,
    cargo_fk NUMBER(3) CONSTRAINT fun_cargo_fk REFERENCES cargo
);

DESC funcionario;

CREATE TABLE funcionario1 (
    cd_fun NUMBER(3) CONSTRAINT fun_cd_pk1 PRIMARY KEY,
    nm_fun VARCHAR2(30) CONSTRAINT fun_nm_nn1 NOT NULL,
    dt_adm DATE CONSTRAINT fun_dt_nn1 NOT NULL,
    uf_fun CHAR(2) CONSTRAINT fun_uf_nn1 NOT NULL,
    cargo_fk REFERENCES cargo
);
