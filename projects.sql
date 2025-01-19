-- data cleaning

select *
from layoffs;

-- 1 Remove duplicates
-- 2 Standardize the data
-- 3 Null values or blank values
-- 4 Remove any columns


CREATE TABLE layoffs_staging
LIKE layoffs;

select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

select *,
row_number() over(
PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) AS row_num
from layoffs_staging;

with duplicate_cte AS
(
select *,
row_number() over(
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised) AS row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 2;

select *
from layoffs_staging
where company='eBay';

with duplicate_cte AS
(
select *,
row_number() over(
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised) AS row_num
from layoffs_staging
)
delete
from duplicate_cte
where row_num > 1;




CREATE TABLE layoffs_staging2 (
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT,
  `total_laid_off` INT DEFAULT NULL,
  `percentage_laid_off` TEXT,
  `date` TEXT,
  `stage` TEXT,
  `country` TEXT,
  `funds_raised` DOUBLE DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
select *
from layoffs_staging2;


insert into layoffs_staging2
select *,
row_number() over(
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised) AS row_num
from layoffs_staging;

DELETE FROM layoffs_staging2
WHERE row_num > 1;


select *
from layoffs_Staging2
where row_num > 2;






