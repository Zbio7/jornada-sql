
select	gender,avg(age)
from employee_demographics
group by gender;
                                         #o group by meio que dá uma amassada nas variaveis de modo que fica só uma , afastando a poluição visual
                                         #no exemplo debaixo  fica dois office mananger pq os salarios não diferentes , mas se tem só um ia
select occupation,salary
from employee_salary
group by occupation,salary;

select	gender,avg(age),max(age),min(age),count(age)     #count conta as rows
from employee_demographics
group by gender;


-- order by   ordena por ordem  alfabetica , mas se colocar o ASC  é ascending e Desc é descending
select *
from employee_demographics
order by first_name desc;

select *
from employee_demographics
order by gender desc,age asc;

# nao recomendado mas  da pra fazer pela numeraçao da  posição 
select *
from employee_demographics
order by 5,4

