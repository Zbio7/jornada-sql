-- Temporary tables

CREATE TEMPORARY  TABLE temp_table                      # tirar o temporary ele cria uma tabela embaixo do 'park_and recreation' nao queremos isso rsrsr
( first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)

)                          
;

SELECT *
FROM temp_table
;
                                                           # inserindo dados na nossa tab temporaria... 
INSERT INTO temp_table
VALUES('Pedro','Queixada','10 mandamentos')
;

SELECT *
FROM temp_table
;


SELECT*
FROM employee_salary
;


CREATE TEMPORARY TABLE salario_acima_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salario_acima_50k;                     # vai funcionar enquanto vc tiver logado nessa sessao fechar nao funfa?