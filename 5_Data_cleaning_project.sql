-- Data cleaning  ...  importei um CSV  no create a new schema etc


SELECT *
FROM layoffs;


-- 1.Remover duplicados
-- 2. padronizar o dado   (ortografia etc)
-- 3. nulos e brancos  popular eles as vezes sim as vezes n
-- 4. remover colunas que são irrelevantes ou rows

-- no mundo real as vezes não é bom alterar raw datas então vamos criar uma table aqui                  nota :atualiza

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;                     # temos as colunas 

INSERT layoffs_staging                   # inserindo dados         agora roda novamente  o  de cima
SELECT *
FROM layoffs;

#remover possiveis duplicadas

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, industry,total_laid_off, percentage_laid_off,`date`) AS row_num              #date com ``pq date é uma palavra reservada!
FROM layoffs_staging;


#transformando em cte

WITH duplicate_cte  AS 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location, industry,total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num              
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;



#criando uma tabela pra deletar os valores maior que 1, adicionei esse row num                                  # acha isso em copy clipboard create statment

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *                                                     #populando com as infos
FROM layoffs_staging2; 

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location, industry,total_laid_off, percentage_laid_off,`date`,stage,country,
funds_raised_millions) AS row_num              
FROM layoffs_staging;

SELECT*
FROM layoffs_staging2
WHERE row_num > 1 ;

-- padronizando 

SELECT company,(TRIM(company))          # trin tira os espaços
from layoffs_staging2;

UPDATE layoffs_staging2
SET company =TRIM(company);

SELECT DISTINCT industry                            # sem distinct aparece duas  vezes itens da lista
from layoffs_staging2
ORDER BY 1;


SELECT*                                # descobrindo quem é crypto'alguma coisa'  pra transformar tudo em um balaio só
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';  

UPDATE layoffs_staging2                                    #pronto agora roda o anterior devolta pra ver
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';   


SELECT DISTINCT industry    
FROM layoffs_staging2;

SELECT DISTINCT country               #botaram um .      no united states 
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country ,TRIM(TRAILING '.' FROM country)                 # esse trailing remove o ponto , pois trailing aqui significa  vindo do final.. tanto é que se eu colocar o 'a' argentina vira argentin por exemplo
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,                                                           #mudando o formato da data de string pra data 
STR_TO_DATE(`date`,'%m/%d/%Y')                                            #pegando o formato joga Y maiusculo mesmo ^^ 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');


SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2                                             #alterar o formato da coluna toda, nunca faça isso numa raw ... 
MODIFY COLUMN `date` DATE;

-- funcionou mudou o definition na aba do lado 'schemas'.. a agora é date

SELECT *
FROM layoffs_staging2;

#trabalhando com nulls

SELECT *                                        #querendo apagar rows com nulls seguidos
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';                                  #pode ver que  tem um 'industry' vazio.. temos que pooular pra ficar que nem embaixo

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';                       #vendo esse

SELECT *                                                    # logiquinha bacana essa hein ^^
FROM layoffs_staging2 tab1
JOIN layoffs_staging2 tab2
	ON  tab1.company = tab2.company
WHERE tab1.industry IS NULL 
AND tab2.industry IS NOT NULL
    ;
    
    #vams poupular 
    
UPDATE layoffs_staging2 tab1
JOIN layoffs_staging2 tab2
	ON  tab1.company = tab2.company
SET tab1.industry =tab2.industry
WHERE (tab1.industry IS NULL OR tab1.industry = '')
AND tab2.industry IS NOT NULL;                                      # Se formos lá em cima e rodar  SELECT * FROM layoffs_staging2 WHERE company = 'Airbnb';    vai ter um industry em branco
																	# por isso é bom transformar  tudo em NULL primeiro pra trabalhar    *  botei um update pra fazer virar null
																   

SELECT *
FROM layoffs_staging2;


# vamos deletar  as rows que tem  null no total laid off e percentage laiid off
SELECT *                                      
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;                            

DELETE                                       
FROM layoffs_staging2                                 #tenta selecionar acima ehhe
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
                                               
SELECT *
FROM layoffs_staging2;               #não confiamos que foi tudo deletado  hehe


                                  # alterar e tirar dropa coluna
ALTER TABLE layoffs_staging2  
DROP COLUMN row_num;


