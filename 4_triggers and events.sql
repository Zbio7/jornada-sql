-- Triggers and events

SELECT*
FROM employee_demographics;


SELECT*
FROM employee_salary;


DELIMITER $$
CREATE TRIGGER inserindo
	AFTER INSERT ON employee_salary                                          #pode ser before (se algo for deletado na tabela tal) mas ofoco aqu ié update
    FOR EACH ROW                                                                    #pra cada linha inserida
BEGIN
	INSERT INTO employee_demographics(employee_id, first_name,last_name)
	VALUES (NEW.employee_id,NEW.first_name, NEW.last_name);                             #só as linhas inseridas ,  pode ser old mas é pra deletadas etc
END $$
DELIMITER ;

INSERT INTO employee_salary(employee_id, first_name,last_name,occupation,salary,dept_id)
VALUES (13,'julio', 'bahia','jogador',10000,NULL);                                              #acrescentando na tabela      e o trigger atualizou tmb na tabela demografica  que legal!!

-- EVENTS

SELECT*
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_aposentados
ON SCHEDULE EVERY 30 SECOND                             #pode ser month second,week                                 deletou  agendado
DO                                                                #faca isso a cada 30 secs
BEGIN
	DELETE
	FROM employee_demographics
	WHERE age>=60;

END $$
DELIMITER ;

#ver se um evento ta funfando
SHOW VARIABLES LIKE 'event%';