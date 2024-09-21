-- Atividade 01 - Gestão de Sócios e Dependentes
-- (15-Mar-2023)

------------------------------------
-- Data do CHECKPOINT 01 - (29-Mar-2023)
------------------------------------

-- Execute os comandos SQL necessários para realizar as operações especificadas na atividade 01

DROP TABLE cidade CASCADE CONSTRAINTS;
DROP TABLE socio CASCADE CONSTRAINTS;
DROP TABLE setor CASCADE CONSTRAINTS;
DROP TABLE dependente CASCADE CONSTRAINTS;

-- 01.Criar a tabela CIDADE, conforme a especificação.
CREATE TABLE cidade (
    codigo NUMBER(4) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL
);

-- 02.Criar a tabela SOCIO, conforme a especificação.
CREATE TABLE socio (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR2(20) NOT NULL,
    datanasc DATE NOT NULL,
    rg VARCHAR2(15) NOT NULL,
    cidade NUMBER(4) NOT NULL,
    FOREIGN KEY (cidade) REFERENCES cidade (codigo)
);

-- 03. Alterar a tabela CIDADE para incluir nela o campo especificado.
ALTER TABLE cidade ADD uf CHAR(2);

-- 04. Alterar a tabela SÓCIO para incluir nela os campos especificados.
ALTER TABLE socio ADD fone VARCHAR2(10);
ALTER TABLE socio ADD sexo CHAR(1) NOT NULL;

-- 05. Alterar, na tabela SÓCIO, o tipo do campo NOME para alfanumérico de tamanho 35.
ALTER TABLE socio MODIFY nome VARCHAR2(35);

-- 06. Criar a tabela SETOR, conforme a especificação abaixo.
CREATE TABLE setor (
    codigo NUMBER(3) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL
);

-- 07. Alterar a tabela SÓCIO para incluir o campo especificado.
ALTER TABLE socio add setor NUMBER(3) NOT NULL REFERENCES setor;

-- 08. Criar a tabela DEPENDENTE, conforme a especificação.
CREATE TABLE dependente (
    socio CHAR(11) NOT NULL,
    numero NUMBER(4) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL,
    datanasc DATE NOT NULL,
    FOREIGN KEY (socio) REFERENCES socio (cpf)
);

-- 09. Incluir duas linhas de dados para cada tabela

INSERT INTO cidade VALUES (1, 'São Paulo', 'SP');
INSERT INTO cidade VALUES (2, 'Paraty', 'RJ');
COMMIT;

SELECT * FROM cidade;

INSERT INTO setor VALUES (1, 'Administrativo');
INSERT INTO setor VALUES (2, 'Contábil');
COMMIT;

SELECT * FROM setor;

INSERT INTO socio VALUES ('23456789012', 'Marcos Pereira', '16-Fev-1985', 'RJ2345678', 2, '987654321', 'M', 2);
INSERT INTO socio VALUES ('34567890123', 'Ana Souza', '05-Jul-1992', 'SP3456789', 1, '912345678', 'F', 1);
COMMIT;

SELECT * FROM socio;

INSERT INTO dependente VALUES ('34567890123', 1, 'Guilherme Silva', '11-Nov-2015');
INSERT INTO dependente VALUES ('23456789012', 2, 'Rosana Pereira', '04-02-1996');
COMMIT;

SELECT * FROM dependente;
