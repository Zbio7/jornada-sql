-- CTE   common table expression


WITH CTE_EXEMPLO AS
(
SELECT gender,AVG(salary) avg_sal,MAX(salary) max_sal,MIN(salary) min_sal,COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)

SELECT AVG(avg_sal)
FROM  CTE_EXEMPLO                                                                                                                                                # aqui ó

;
                                                             # mesmo resultado mas os especialistas falam que o de cima é mais legível

SELECT AVG(avg_sal)
FROM (
SELECT gender,AVG(salary) avg_sal,MAX(salary) max_sal,MIN(salary) min_sal,COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)exemplo_subquery


;
                                           # CTE só poder usar depois imediatamente exemplo nao pode depois do   '  ;   '  pq ñ é um objeto permanente  la em cima pega    -----^
SELECT AVG(avg_sal)
FROM  CTE_EXEMPLO;                         # aqui não





WITH CTE_EXEMPLO AS
(
SELECT employee_id, gender,birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
),
CTE_EXEMPLO2   AS
(
SELECT employee_id,salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM  CTE_EXEMPLO 
JOIN  CTE_EXEMPLO2
    ON CTE_EXEMPLO.employee_id = CTE_EXEMPLO2.employee_id                                             #da pra fazer usando puro jooin .. mas é pra ver que da pra fazer multiploes CTE
;



WITH CTE_EXEMPLO (Gender,salario_media,salario_max,salario_min,count_sal) AS                                       # pode padronizar o nome aqui em cima tmb
(
SELECT gender,AVG(salary) avg_sal,MAX(salary) max_sal,MIN(salary) min_sal,COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)

SELECT *
FROM  CTE_EXEMPLO                                                                                                                                                # aqui ó





