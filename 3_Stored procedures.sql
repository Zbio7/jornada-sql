-- Stored procedures

SELECT *
FROM employee_salary
WHERE salary >= 50000;

#criando o mais basico para o entendimento
CREATE PROCEDURE  large_salary()                                                  #salvou isso no stored procedure abaixo do parks and recreation  tem que apertar no atualizar pra ver
SELECT *
FROM employee_salary
WHERE salary >= 50000;

#chamando o  stored

CALL large_salary();


#mudando o delimitador  pra cifrao para o ; nao ser barreira dentro   , no final  com as boas praticas revertemos pra nao ficar usando cifrao pra tudo.

DELIMITER $$                                                            
CREATE PROCEDURE  large_salary3()                                                  
BEGIN
	SELECT *                                                                   
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;  

#saiu dois resultados tabs diferentes
 CALL large_salary3()             
 
 # uma coisa legal, é que dá pra criar os stored procedures  clicando lá na interface ao lado! Criei o new_procedure ;)
 -- 
 
 
 -- Passando um parametro  INT de inteiro..
                                                -- usei um nome qualquer pra nao confundir, mas usa um nome que tenha haver
 DELIMITER $$                                                            
CREATE PROCEDURE  large_salary4(qualquercoisa INT)                                                  
BEGIN
	SELECT salary                                                                
	FROM employee_salary
    WHERE employee_id = qualquercoisa
    ;


END $$
DELIMITER ;  


# muito legal, pelo record id conseguimos ver o salário
 call large_salary4(1) 
 
 
 
 
 
 