-- Exploratory data analysis

SELECT*
FROM layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;


SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off=1
order by funds_raised desc;



SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
order by 2 desc;


SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;


SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
order by 2 desc;


SELECT*
FROM layoffs_staging2;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
order by 1 desc;


SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
order by 2 desc;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
order by 2 desc;


SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
where SUBSTRING(`date`,1,7) is not null
GROUP BY `MONTH`
order by 1 asc
;

WITH Rolling_total AS
(
 SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
where SUBSTRING(`date`,1,7) is not null
GROUP BY `MONTH`
order by 1 asc
)
SELECT `MONTH`,total_off,
SUM(total_off) OVER(order by `MONTH`) AS rolling_total
from Rolling_total;



SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
order by 2 desc;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
order by 3 desc;


WITH Company_Year (company,years,total_laid_off ) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
), Company_Year_Rank AS 
(SELECT* ,DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off desc) AS Rank_distribution
FROM Company_Year
WHERE years is not null
)
SELECT*
FROM Company_Year_Rank
WHERE Rank_distribution <=5
;







