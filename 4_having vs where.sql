-- having vs where

-- nao vai pegar pq a variavel avg (age ainda nao foi criada pra filtrar
select gender, AVG(age)
from employee_demographics
where AVG(age) > 40
group by gender


;

select gender, AVG(age)
from employee_demographics
group by gender
having AVG(age) > 40
;

select occupation,avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000
;

-- having usa depois do group by   o  where usa antes dos dados serem agregados ou melhor agrupados pelo group by