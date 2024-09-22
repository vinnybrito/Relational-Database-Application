-- CHECKPOINT 01 - 1TDSPR - 2023
-- (29-Mar-2023)

-- PROJETO: Oficina de veículos
/*
    OBJETIVO: Gerenciar os serviços contratados pelos clientes (manutenção, revisão, funilaria 
    e pintura), identificar problemas, peças a serem trocadas, atendimento particular e de 
    seguradoras, prazos de realização dos serviços, orçamentos e demais atendimentos que uma 
    oficina pode realizar.
    
    Criar usando a ferramenta BRModelo a documentação: 
    DER (3,0 pts), MLR (0,5 pt)e MF (1,5 pt) – até 5,0 pts;
    
    Desenvolver a parte prática, implementação SQL com a ferramenta Sql Developer
    Passo para a prática: - até 5,0 pts (cada item 1,0 pt)
*/

SELECT table_name FROM user_tables;

DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE veiculo CASCADE CONSTRAINTS;
DROP TABLE orcamento CASCADE CONSTRAINTS;
DROP TABLE servico CASCADE CONSTRAINTS;
DROP TABLE peca CASCADE CONSTRAINTS;
DROP TABLE utiliza CASCADE CONSTRAINTS;

-- A) Escolha três tabelas (que estejam relacionadas) para serem criadas sem a 
-- implementação da chave primária.

CREATE TABLE cliente (
    id_cliente NUMBER(11),
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    cidade VARCHAR(80) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    email VARCHAR(100) NOT NULL
);
ALTER TABLE cliente ADD PRIMARY KEY (id_cliente);

CREATE TABLE veiculo (
    id_veiculo NUMBER(7),
    id_cliente NUMBER(11),
    modelo VARCHAR(50),
    cor VARCHAR(11),
    ano_fabricacao DATE
);
ALTER TABLE veiculo ADD PRIMARY KEY (id_veiculo);

CREATE TABLE orcamento (
    id_orcamento NUMBER(10),
    id_veiculo NUMBER(7),
    data_orcamento DATE,
    valor NUMBER(10,2),
    status VARCHAR(20)
);
ALTER TABLE orcamento ADD PRIMARY KEY (id_orcamento);
ALTER TABLE orcamento ADD FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo);

CREATE TABLE servico (
    id_servico NUMBER(10) PRIMARY KEY,
    descricao VARCHAR(200),
    tipo_manutencao VARCHAR(100),
    preco NUMBER(10,2)
);

CREATE TABLE peca (
    id_peca NUMBER(5) PRIMARY KEY,
    tipo_peca VARCHAR(50),
    quantidade NUMBER(8),
    preco_peca NUMBER(10,2)
);

CREATE TABLE utiliza (
    id_peca NUMBER(10),
    id_servico NUMBER(10),
    quantidade_util NUMBER(10),
    PRIMARY KEY (id_peca, id_servico)
);
ALTER TABLE utiliza ADD FOREIGN KEY (id_peca) REFERENCES peca(id_peca);
ALTER TABLE utiliza ADD FOREIGN KEY (id_servico) REFERENCES servico(id_servico);

-- B) As pks devem ser criadas usando o comando alter table.
ALTER TABLE cliente ADD PRIMARY KEY (id_cliente);
ALTER TABLE veiculo ADD PRIMARY KEY (id_veiculo);
ALTER TABLE orcamento ADD PRIMARY KEY (id_orcamento);

-- C) Os relacionamentos devem ser criados usando o comando alter table.
ALTER TABLE orcamento ADD FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo);
ALTER TABLE utiliza ADD FOREIGN KEY (id_peca) REFERENCES peca(id_peca);
ALTER TABLE utiliza ADD FOREIGN KEY (id_servico) REFERENCES servico(id_servico);

-- D) Realizar a inserção de duas linhas de dados em todas as tabelas criadas.

INSERT INTO cliente VALUES (1, 'João Silva', 'Rua das Flores, 123', 'São Paulo', '01000-000', 'joao.silva@email.com');
INSERT INTO cliente VALUES (2, 'Maria Oliveira', 'Av. Brasil, 456', 'Rio de Janeiro', '02000-000', 'maria.oliveira@email.com');
COMMIT;

SELECT * FROM cliente;

INSERT INTO veiculo VALUES (1, 1, 'Fusca', 'Azul', '01-Jan-1999');
INSERT INTO veiculo VALUES (2, 2, 'Civic', 'Preto', '01-Jan-2018');
COMMIT;

SELECT * FROM veiculo;

INSERT INTO orcamento VALUES (1, 1, '15-Mar-2023', 450.00, 'Aprovado');
INSERT INTO orcamento VALUES (2, 2, '16-Mar-2023', 1200.00, 'Pendente');
COMMIT;

SELECT * FROM orcamento;

INSERT INTO servico VALUES (1, 'Troca de óleo', 'Manutenção', 150.00);
INSERT INTO servico VALUES (2, 'Reparo de freios', 'Reparo', 300.00);
COMMIT;

SELECT * FROM servico;

INSERT INTO peca VALUES (1, 'Filtro de óleo', 10, 25.00);
INSERT INTO peca VALUES (2, 'Pastilhas de freio', 5, 80.00);
COMMIT;

SELECT * FROM peca;

INSERT INTO utiliza VALUES (1, 1, 2);
INSERT INTO utiliza VALUES (2, 2, 4);
COMMIT;

SELECT * FROM utiliza;

-- E) Escolha uma das tabelas e realize dois processamentos de update.
UPDATE cliente SET endereco = 'Rua Rosa Branca'
WHERE id_cliente = 1;

UPDATE cliente SET cep = '03000-000' 
WHERE id_cliente = 2;

SELECT * FROM cliente;

-- F) Escolha uma das tabelas e realize o processamento de modificação do tamanho de 
-- uma coluna
ALTER TABLE veiculo MODIFY modelo VARCHAR(80);

DESC veiculo;
