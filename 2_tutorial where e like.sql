select *
from employee_salary
where first_name = 'Leslie'
;

# where seleciona as rows com condições específicas 

select *
from employee_salary
where salary < 50000
;

select *
from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55
;

select *
from employee_demographics
where birth_date >'1987-03-04'
or not gender = 'male'

;
-- like statement    o  ' % ' significa qualquer coisa depois não importa rodando dá jerry (pode botar o % atrás tmb)

select *
from employee_demographics
where first_name like 'Jer%'
;

-- e o ' _ ' valor especifico  rodando dá ann dois underline se botar 3 vai dá andy     dá pra misturar com o  % aí vai dar o nome da april
select *
from employee_demographics
where first_name like 'a__'
;

-- com data tmb dá
select *
from employee_demographics
where birth_date like '1980%'
;