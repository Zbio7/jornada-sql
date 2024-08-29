-- Window Function 

#fazendo como group by pra comparar com o window function
SELECT gender, AVG(salary) as avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
    
 ;          

SELECT gender, AVG(salary) OVER(PARTITION BY gender)                         # particiona estilo group by mas mais 'solto'       
FROM employee_demographics dem                                                #esse metodo é bom caso vc queira add outras coisas  veja o prox exemplo
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

 
 SELECT dem.first_name,dem.last_name, AVG(salary) OVER(PARTITION BY gender)          # não muda nada viu?       se fizer por group by muda.                    
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
    
SELECT dem.first_name,dem.last_name,gender, salary,   
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total                        # Rolling_Total    ou running total é soma acumulativa tipo [2,3,4] o running total é 9     
FROM employee_demographics dem                                                                          # add a coluna salary pra ter essa noção 
JOIN employee_salary sal                                                                                 # com window function é bacana dá pra ver o rolling total das mulheres e dos homens
	ON dem.employee_id = sal.employee_id
    
    ;
    
    -- mostrar coisas especiais que só podem ser feitas com o window function
                                                                                       #row number dá o numero pique um ID , aí brincamos com um partitions e order by 
SELECT dem.employee_id,dem.first_name,dem.last_name,gender, salary,   
ROW_NUMBER()OVER(PARTITION BY gender ORDER BY salary DESC)  row_num, 
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_num,                           # o rank é muito maneiro se empate ele repete a o mesmo row number no exemplo ele pulou o numero 6
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_num                      # já o dense rank  respeita e o empate e joga o numero seguinte no caso o 6
FROM employee_demographics dem                                                                        
JOIN employee_salary sal                                                                                 
	ON dem.employee_id = sal.employee_id                                                  
    
    
    ; 