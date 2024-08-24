-- join  

-- permite conectar tables que tem uma coluna em comum 

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- juntar as duas de cima

SELECT *                                        # aqui vai dar erro  de ambiguidade pq ele nao sabe de qual tabela o employee_id é;
FROM employee_demographics
INNER JOIN employee_salary
     ON employee_id = employee_id
;
                                                    # assim funfa  juntou as duas    ..  ob o numero dois  nao aparece pq ele nao existe na demografica , só na salario
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
     ON dem.employee_id = sal.employee_id
;

# vamo selecionar algumas aqui

SELECT dem.employee_id,age,occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
     ON dem.employee_id = sal.employee_id
;

-- outer join (são dois o left e o right)                          vai pegar o da esquerda e  vai retornar com os matches da direita
# veja que o employee demografic é o da esquerda
# ve que o rapaz numero 2 nem aparece

SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
     ON dem.employee_id  = sal.employee_id;

-- vamos fazer um right pra ver
-- ele retorna os matches da esquerda e se não tiver ele retorna um null   veja o  caso de ron swanson (numero 2)
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
     ON dem.employee_id = sal.employee_id
     ;


-- self join                      o self join  une ela mesma duas tabs iguais ... aqui fizemos uma brincadeira de amigo oculto  selecionando e renomeando as colunas 
							    --  

                                                        -- o ON é o termo em comum   
SELECT emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
FROM employee_salary emp1                        # sem o AS funfa tmb  .. emp de employee mais pra diferenciar quem é quem ja que as duas sao iguais
JOIN employee_salary emp2
	ON emp1.employee_id + 2 = emp2.employee_id    # aqui acrescentou mais 1 a cada id pra  atribuir a uma pessoa .. pra brincadeira rolar, se tu tirar o +1 ou acrescer outro numero vai ver
    
    ;

-- juntar multiplas tabelas

SELECT *                                                        #juntamos todas as 3 tabelas com o dept_id e o department_id   o demografico não tem mas o salary tem em comum :)
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
     ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	 ON sal.dept_id = pd.department_id
;

SELECT *
FROM parks_departments
     