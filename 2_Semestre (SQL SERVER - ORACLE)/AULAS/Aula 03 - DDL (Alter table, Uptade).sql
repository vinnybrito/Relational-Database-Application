-- Aula 03 - DDL (Alter table, Uptade)
-- (01-Mar-2023)

-- Ainda trabalhando com estrutura das tabelas

-- Alterando ou corrigindo uma estrutura
ALTER TABLE nome_tabela;

OP��ES:
    ADD COLUMN - nova coluna
    ADD CONSTRAINT - nova regra
    MODIFY - modifica tipo e/ou tamanho de uma coluna
    DROP COLUMN - elimina uma coluna
    DROP CONSTRAINT - elimina uma regra

------------------------------------

-- Tabela para relizar testes DDL
CREATE TABLE tb_teste (
    codigo NUMBER(2),
    nome NUMBER(10)
);

------------------ INCLUIR ------------------

-- Incluindo uma nova coluna
ALTER TABLE tb_teste ADD dt_nasc DATE;

-- Incluindo uma coluna com regra
ALTER TABLE  tb_teste ADD cep CHAR(8) NOT NULL;

-- Incluindo a pk na coluna codigo
ALTER TABLE  tb_teste ADD CONSTRAINT pk_cod PRIMARY KEY (codigo);

------------------ MODIFICAR ------------------

-- Modificando apenas o tipo de dados
ALTER TABLE tb_teste MODIFY nome VARCHAR(10);

-- Modificando apenas o tamanho da coluna
ALTER TABLE tb_teste MODIFY nome VARCHAR(50);

-- Modificando tamanho e tipo ao mesmo tempo
ALTER TABLE tb_teste MODIFY nome NUMBER(10);

------------------ ELIMINAR ------------------

-- Eliminando uma regra
ALTER TABLE tb_teste DROP CONSTRAINT pk_cod;

DESC tb_teste;
DESC user_constraints;

SELECT constraint_name FROM user_constraints 
WHERE table_name = 'TB_TESTE';

-- Eliminando uma coluna
ALTER TABLE tb_teste DROP COLUMN nome;

DESC tb_teste;

-- Eliminando uma tabela (drop table nome_tabela)
DROP TABLE tb_teste;

------------------RENOMEAR------------------

-- Renomeando uma coluna
ALTER TABLE tb_teste RENAME COLUMN codigo TO cod_cliente;

-- Renomeando uma constraint
ALTER TABLE tb_teste RENAME CONSTRAINT sys_c003509437 TO fiap;

------------------ CASCADE CONSTRAINTS ------------------

CREATE TABLE tb_teste1 (
    codigo NUMBER(1) primary key
);

CREATE TABLE tb_teste2 (
    codigo number(1) references tb_teste1
);

INSERT INTO tb_teste1 VALUES(1);
INSERT INTO tb_teste2 VALUES(1);

-- Uso do cascade permite eliminar o relacionamento e depois dropar a tabela
DROP TABLE tb_teste1 CASCADE CONSTRAINTS;

------------------------------------

Atualizando dados

UPDATE 

Operadores - aritm�ticos: + - * / ()
             relacionais: > >= < <= = != ou <>
             l�gicos: and, or, not
 
-- Sintaxe:       
UPDATE nome_tabela SET nome_coluna = novo_valor;

UPDATE nome_tabela SET nome_coluna = novo_valor
WHERE condi��o;

------------------------------------

-- Teste UPDATE

CREATE TABLE produto_tb (
    cod_prod NUMBER(4) CONSTRAINT prod_cod_pk PRIMARY KEY, 
    unidade VARCHAR2(3),
    descricao VARCHAR2(20),
    val_unit NUMBER(10,2)
);

-- Inserindo Dados
INSERT INTO produto_tb VALUES (25,'KG','Queijo',0.97);
INSERT INTO produto_tb VALUES (31,'BAR','Chocolate',0.87);
INSERT INTO produto_tb VALUES (78,'L','Vinho',2.00);
INSERT INTO produto_tb VALUES (22,'M','Linho',0.11);
INSERT INTO produto_tb VALUES (30,'SAC','Acucar',0.30);
INSERT INTO produto_tb VALUES (53,'M','Linha',1.80);
INSERT INTO produto_tb VALUES (13,'G','Ouro',6.18);
INSERT INTO produto_tb VALUES (45,'M','Madeira',0.25);
INSERT INTO produto_tb VALUES (87,'M','Cano',1.97);
INSERT INTO produto_tb VALUES (77,'M','Papel',1.05);
COMMIT;

SELECT * FROM produto_tb;

-- Atualizando os dados do pre�o do produto para R$1,00
UPDATE produto_tb SET val_unit = 1;

-- Atualizando os dados do pre�o do produto para R$1,5
-- apenas dos produtos de unidade de medida igual a metro
UPDATE produto_tb SET val_unit = 1.5
WHERE unidade = 'M';

SELECT * FROM produto_tb ORDER BY 1;

-- Atualizar em 15% o pre�o dos produtos de c�digo maior que 30.
UPDATE produto_tb SET val_unit = val_unit * 1.15
WHERE cod_prod > 30;

-- Atualizar o nome do produto queijo para queijo de minas.
UPDATE produto_tb SET descricao = 'Queijo De Minas'
WHERE descricao = 'Queijo';

-- Para os produtos a�ucar, madeira e Linha zerar o seu pre�o.
UPDATE produto_tb SET val_unit = 0
WHERE descricao = 'Acucar' OR descricao = 'Linha'
OR descricao = 'Madeira';

SELECT * FROM produto_tb;

DESC produto_tb;
