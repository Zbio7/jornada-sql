-- Subqueries



SELECT *                                                  #ele retorna os matchs  tiver dentro da outra ação  , ve que o numero dois nem aparece pq ele só existe na de salário
FROM employee_demographics
WHERE employee_id IN
				(SELECT employee_id                          #se tavar outra coluna aqui não vai...  da um erro operand should contain 1 columm .. IN é o operador e o operand é o bloco
                     FROM employee_salary
                     WHERE dept_id = 1)
;
-- exemplo de como ver a media salarial criando uma coluna com subquery

SELECT first_name, salary,                      
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;


SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)                          # um treininho pra ver                  
FROM employee_demographics
GROUP BY gender
;

SELECT *                                                         # wow  engoliu o treininho que interessante...
FROM 
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)                                        
FROM employee_demographics
GROUP BY gender) AS treininho
;

SELECT gender, AVG(`MAX(age)`)                                                      # ao invés de selecionar tudo vamos  pegar as colunas do nosso treininho  tem que colocar '' pra ele reconhecer
FROM 
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)                                        
FROM employee_demographics
GROUP BY gender) AS treininho
GROUP BY gender

;

SELECT  AVG(Max_age)                                                      # mas como somos profis vamos fazer de maineira melhor
FROM                                                           
(SELECT gender,
 AVG(age) AS avg_age,
 MAX(age) AS Max_age,
 MIN(age) AS Min_age,
 COUNT(age)                                        
FROM employee_demographics
GROUP BY gender) AS treininho                                               # a média da média 

