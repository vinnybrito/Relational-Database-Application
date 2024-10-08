-- Aula 01 - Introdução blocos anônimos 
-- (07/08/2023)

-- 1º Comando a ser executado:
-- Habilitando a saída de dados de um bloco PL

SET SERVEROUTPUT ON

--------------------------

-- 1º Programa

BEGIN
    DBMS_OUTPUT.PUT_LINE('Bloco Ok!!!');
END;

--------------------------

-- Trabalhando com variáveis

DECLARE
    v1 NUMBER(2) := 10;
    v2 NUMBER(2) := 10;
    re NUMBER(3);
BEGIN
    re := v1 + v2;
    DBMS_OUTPUT.PUT_LINE(re);
END;

--------------------------

-- Imprimir mensagem e concatenar

DECLARE
    v1 NUMBER(2) := 10;
    v2 NUMBER(2) := 10;
    re NUMBER(3) := v1 + v2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || re);
END;

--------------------------

-- Entrada de dados via teclado

DECLARE
-- Declaração de vm
-- Uso de variaveis de substituição
    v1 NUMBER(2) := &valor_1;
    v2 NUMBER(2) := &valor_2;
-- Processamento
    re NUMBER(3) := v1 + v2;
BEGIN
-- Saída de dados
    DBMS_OUTPUT.PUT_LINE('resultado: ' || re);
END;
-- Fim programa


------------ EXERCÍCIOS ------------

-- 01 - Criar um bloco PL-SQL para calcular o valor do novo salário 
-- mínimo que deverá ser de 25% em cima do atual, que é de R$1320.

SET SERVEROUTPUT ON
DECLARE
    v_sal_atual NUMBER(10,2) := 1320.00;
    v_sal_reaj NUMBER(10,2);
BEGIN
    v_sal_reaj := v_sal_atual * 1.25;
    DBMS_OUTPUT.PUT_LINE('Salário atual - R$: ' || v_sal_atual);
    DBMS_OUTPUT.PUT_LINE('Salário reajustado - R$: ' || v_sal_reaj);
END;
/

------------ Ex2 -------------

-- 02 - Criar um bloco PL-SQL para calcular o valor em REAIS de 
-- 45 dólares, sendo que o valor do câmbio a ser considerado é de 
-- R$ 4.90 no qual estes valores deverão ser constantes dentro do bloco.

SET SERVEROUTPUT ON
DECLARE
    v_dolar NUMBER(10,2) := 4.90;
    v_real v_dolar%TYPE := v_dolar * 45;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Cotação dólar 08/08/2023: ' || v_dolar);
    DBMS_OUTPUT.PUT_LINE('Conversão US$ 45.00 em R$: ' || v_real);
END;
/

------------ Ex3 -------------

-- 03 - Criar um bloco PL-SQL para converter em REAIS os dólares 
-- informados, sendo que o valor do Câmbio a ser considerado é de 5,35.

SET SERVEROUTPUT ON
DECLARE
    v_dolar number(8,2) := 9.18;
    v_cota v_dolar%type := 4.90;
    v_real v_dolar%type;
BEGIN
    v_real := v_dolar * v_cota;
    DBMS_OUTPUT.PUT_LINE('US$ ' || v_dolar || ' convertido em Real: ' || v_real);
END;

------------ Ex4 -------------

-- 04 - Criar um bloco PL-SQL para calcular o valor das 
-- parcelas de uma compra de um carro, nas seguintes condições: 

-- OBSERVAÇÃO: 
-- 1 - Parcelas para aquisição em 10 pagamentos. 
-- 2 - O valor total dos juros é de 3% e deverá ser aplicado 
-- sobre o montante financiado.
-- 3 – No final informar o valor de cada parcela.

SET SERVEROUTPUT ON
DECLARE
    v_bem number(10,2) := &valor_bem;
    v_parc v_bem%type:= v_bem * 1.03 / 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Valor do bem R$ ' || v_bem);
    DBMS_OUTPUT.PUT_LINE('Em 10x com 3% de juros - R$ ' || v_parc);
END;

------------ Ex5 -------------

-- 05 - Criar um bloco PL-SQL para calcular o valor de cada 
-- parcela de uma compra de um carro, nas seguintes condições:
-- - Parcelas para aquisição em 6 pagamentos. 
-- - Parcelas para aquisição em 12 pagamentos. 
-- - Parcelas para aquisição em 18 pagamentos. 

-- OBSERVAÇÃO: 
-- 1 – Deverá ser dada uma entrada de 20% do valor da compra. 
-- 2 – Deverá ser aplicada uma taxa juros, no saldo restante, nas 
-- seguintes condições: 
-- 3 – No final informar o valor das parcelas para as 3 formas de 
-- pagamento, com o Valor de aquisição de 10.000.

-- A – Pagamento em 6 parcelas: 10%. 
-- B – Pagamento em 12 parcelas: 15%. 
-- C – Pagamento em 18 parcelas: 20%.

SET SERVEROUTPUT ON
DECLARE
    v_carro NUMBER(10,2) := 50000 * 0.8;
    v_presta v_carro%TYPE;
BEGIN
    v_presta := (v_carro * 1.1) / 6;
    DBMS_OUTPUT.PUT_LINE('Valor da prestação em 6x: ' || v_presta);
    v_presta := (v_carro * 1.15) / 12;
    DBMS_OUTPUT.PUT_LINE('Valor da prestação em 12x: ' || v_presta);
    v_presta := (v_carro * 1.2) / 18;
    DBMS_OUTPUT.PUT_LINE('Valor da prestação em 18x: ' || v_presta);
END;
/