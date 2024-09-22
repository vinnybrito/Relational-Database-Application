-- Atividade 02 - Gest�o de Empregados e Empresas

-- 1) Crie a seguinte tabela a partir da rela��o abaixo:
CREATE TABLE Empregado (
    nome_empregado VARCHAR(50) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    cidade VARCHAR(30),
    estado_civil VARCHAR(15)
);

-- 2) Altere a Tabela Empregado adicionando o atributo Salario num�rico com 9 inteiros e 2 decimais
ALTER TABLE Empregado ADD salario NUMBER(9,2);

-- 3) Altere a Tabela Empregado adicionando o atributo data nascimento como data
ALTER TABLE Empregado ADD data_nascimento DATE;

-- 4) Altere a Tabela Empregado modificando o tamanho do atributo Cidade para 110.
ALTER TABLE Empregado MODIFY cidade VARCHAR(110);

-- 5) Crie a seguinte tabela a partir da rela��o abaixo
CREATE TABLE Companhia (
    nome_companhia VARCHAR(50) PRIMARY KEY,
    cidade VARCHAR(30)
);

-- 6) Altere a Tabela Empregado adicionando Nome_Empregado como chave prim�ria.
ALTER TABLE Empregado ADD PRIMARY KEY (nome_empregado);

-- 7) Crie a seguinte tabela a partir da rela��o. N�o esque�a de definir as chaves estrangeiras
CREATE TABLE Trabalha (
    nome_empregado VARCHAR(50),
    nome_companhia VARCHAR(50) NOT NULL,
    salario NUMBER(9,2) NOT NULL,
    PRIMARY KEY (nome_empregado, nome_companhia),
    FOREIGN KEY (nome_empregado) REFERENCES Empregado (nome_empregado),
    FOREIGN KEY (nome_companhia) REFERENCES Companhia (nome_companhia)
);

-- 8) Crie a seguinte tabela a partir da rela��o.
CREATE TABLE Gerente (
    nome_empregado VARCHAR(50),
    nome_gerente VARCHAR(50),
    FOREIGN KEY (nome_empregado) REFERENCES Empregado (nome_empregado),
    FOREIGN KEY (nome_gerente) REFERENCES Empregado (nome_empregado)
);

-- 9) Delete as tabelas.
DROP TABLE Empregado CASCADE CONSTRAINTS;
DROP TABLE Companhia CASCADE CONSTRAINTS;
DROP TABLE Trabalha CASCADE CONSTRAINTS;
DROP TABLE Gerente CASCADE CONSTRAINTS;
