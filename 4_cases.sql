-- Case Statements 

SELECT  first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'NOVO'
    WHEN age BETWEEN 31 and 50 THEN 'Experiente'
    WHEN age >= 50 THEN "veterano"
END AS classification
FROM employee_demographics;
-- -----------------------------------------------------------------------------------------------
-- pay increase and bonus
-- < 50000 = 5%    se fez menos que 50000 ganha 5 porcento
-- > 50000 = 7%
-- se trabalha no setor de finance ganha 10% de bonus


SELECT first_name,last_name,salary,
CASE
     WHEN salary < 50000 THEN ROUND( salary + (salary/100)*5)               #uma função que arredonda  tira os zeros coloque pra testar
     WHEN salary > 50000 THEN  salary + (salary/100)*7                      # esse calculo da porcentagem da pra fazer     salary * 1.05     
END AS New_salary,
CASE
    WHEN dept_id = 6 THEN (salary/100) * 10                                    #salary * .10
END AS Bonus_setor_financas
FROM employee_salary;

SELECT *
FROM employee_salary;
