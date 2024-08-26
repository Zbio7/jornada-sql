-- STRINGs functions

SELECT length('skyfall');              # quantas letra tem?

SELECT first_name,LENGTH(first_name)
FROM employee_demographics
ORDER BY 2 ;                                       #o order by com numeros são relacionados à coluna.. se eu botasse dois ele ia ordenar pelo nome ;D
												   # o lentgh é bom pra trab com numeros de telefone , cpf etc  pra ter certeza da quantidade de numeros
                                                   
 SELECT UPPER('sky');
 SELECT LOWER('sky');                              # maius e minuscu
 
 SELECT first_name,UPPER(first_name)
FROM employee_demographics                            # bom pra padronização
ORDER BY 2 ;                                       

SELECT TRIM('           bola       ');                # tira os espaços         faz sem o TRIM pra tu vê hehe      se tu botar o L antes do TRIM  ex: LTRIM 
                                                     #remove só o lado esquerdo com R o direito left and right()

SELECT first_name,
LEFT(first_name,4),                                      # esse left é pra selecionar o tamanho até onde tu colocou o numero, se um nome tiver mais de 4 letras é cortado da esquerda pra direita
RIGHT(first_name,4),                                      # o right vai da direita pra esquerda
SUBSTRING(first_name,3,2),                               # começa na terceira posição e vai pra direia  dois caracteres começa do 1 mesmo nao do 0. e pega dois caracteres
birth_date,                                              #exemplo pra saber o mes que a galera faz niver
SUBSTRING(birth_date,6,2) AS Mês_aniversário                                # pegando os numeros do meio que é o mês
FROM employee_demographics;


SELECT first_name,REPLACE(first_name, 'a','z')             # trocar tudo que tem a por z  
FROM employee_demographics;

SELECT LOCATE('r','romario');               #posição 1

SELECT first_name,LOCATE('An',first_name)         #localiza quem tem AN 
FROM employee_demographics;


SELECT first_name,last_name,
CONCAT(first_name,' ',last_name)   AS full_name             #cria uma coluna juntando as strings de duas       joga um truquinho pra deixar separadinho '  '
FROM employee_demographics;         