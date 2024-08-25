-- unions
-- combina rows  nao colunas como os joins




-- nesse exemplo tu vê que ele misturou   la embaixo vc  vê que  tá nome esobreno misturado com genero etc ,,,  o ideal é colocar coisas coerentes  veja no outro codigo abaixo
SELECT first_name,gender
FROM employee_demographics
UNION
SELECT first_name,last_name
FROM employee_salary;

-- agora sim po

SELECT first_name,last_name
FROM employee_demographics
UNION                                       # esse union  por padrao é um union distinct que tira as duplicatas... se tu botar  UNION ALL vai aparecer todos os resultados
SELECT first_name,last_name
FROM employee_salary
;
                                                    # dando uma classificadinha  'véio'
SELECT first_name,last_name,'véio' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name,last_name,'muié véia' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'female'
UNION
SELECT first_name,last_name,'salario alto' AS label
FROM employee_salary
WHERE salary > 70000                                                            #tem que dar um order by pois o leslie e o chris  atingem multiplos critérios de classificaçao aí deixa bonitinho pra ver joga em crescente por padrao
ORDER BY  first_name,last_name                                                   # se tacasse ASC  e DESC
;                                

