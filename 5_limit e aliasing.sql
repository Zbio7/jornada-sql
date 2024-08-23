-- limit and aliasing

# coloca só as top 3  ou seja limita
SELECT *
FROM employee_demographics
LIMIT 3

;

# combinado ordenou pela idade descendente  / usou um limit 2   começa na dois e vai uma após   o exemplo era  limit 3, a posiçao 2 é a donna colocando limit 2,1 seleciona o leslie
 # é tipo um acesso mesmo.
 
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2,1
;

-- ALIASING   dando apelido

SELECT gender, AVG(agE) AS avg_age             #dando apelido pro AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age)>40
;
# fica assim :

SELECT gender, AVG(agE) AS avg_age             #funciona sem o as tmb hein hehe        
FROM employee_demographics
GROUP BY gender
HAVING avg_age >40
;