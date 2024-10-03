-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;

SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;              # ordenar pela segunda coluna

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2

;
                                           #se nao colonar group by dar erro pq tem varias empresas nomes iguais na  coluna , como tá somando.. vc sabe
SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC
;
                                          # analisando os laid off por país
SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT `date`,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC
;

#vendo pelo ano somente
SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC
;

SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC
;

SELECT company,SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;


SELECT SUBSTRING(`date`,6,2)  AS `MONTH` , SUM(total_laid_off)          #na coluna data começa da posição seis e pega dois. O objetivo é pegar o mês 
FROM layoffs_staging2
GROUP BY `MONTH`
;

#demissao por ano
SELECT SUBSTRING(`date`,1,7)  AS `MONTH` , SUM(total_laid_off)        #  O objetivo é pegar o mês  e ano
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

#preparar pra fazer um CTE  , que é  simplificar a escrita de consultas complexas, ajuda a dividir a lógica em partes menores tornando-as mais fáceis para o entendimento.


WITH rolling_total AS
(SELECT SUBSTRING(`date`,1,7)  AS `MONTH` , SUM(total_laid_off) AS total_off     
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC

)
SELECT `MONTH`,total_off                                                          # aqui vemos a magia do rolling_total acontecer .. é uma soma acumulativa  ao longo dos meses..
,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM rolling_total
;                                                                        



SELECT company,SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;



 # Criamos aqui pra ver pra ver quantas pessoas eles demitiram por ano
SELECT company,YEAR(`date`),SUM(percentage_laid_off)                
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3  DESC;

#Criamos o primeiro CTE

WITH Company_Year (company,years,total_laid_off) AS                                           #mudou o nome das colunas no CTE

(
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3  DESC

# ai demos um rank pro nosso CTE   pra facilitar a filtragem lá embaixo
),Company_Year_Rank AS
(
SELECT *,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking      #  determines the rank of a value in a group of values, based on the ORDER BY expression in the OVER clause. If the optional PARTITION BY clause is present, the rankings are reset for each group of rows.                                                                               
FROM Company_Year
WHERE years IS NOT NULL

)                                           # ó o filtro aqui
SELECT * 
FROM Company_Year_Rank
WHERE ranking <= 5                            # as companias que mais demitiram rankiadas por ano
;