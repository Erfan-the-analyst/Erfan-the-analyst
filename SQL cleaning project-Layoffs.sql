
select *
from layoffs

-- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways

  ------------------------------------------------------------------------------
  
  -- 1. Remove Duplicates;
  
  
create table layoffs_staging
like  layoffs;

INSERT layoffs_staging 
SELECT * 
FROM layoffs;

select*
from layoffs_staging;

select *,
row_number() over(
partition by company, industry, total_laid_off, `date`) as row_num
from layoffs_staging;

with dublicate_cte as
(
select *,
row_number() over(
partition by company,location, industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging
)
select *
from dublicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'oda';


with dublicate_cte as
(
select *,
row_number() over(
partition by company,location, industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staing
)
delete ('this is for removing the ublicate one not the original one in microsoft sql...')
from dublicate_cte
where row_num > 1;

select *
from layoffs_staging;



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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location, industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;

select*
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

select*
from layoffs_staging2
where row_num > 1;



  --------------------------------------------------------------------
  
  -- 2. Standardize Data
  select company, trim(company)
  from layoffs_staging2;
  
  update layoffs_staging2
  set company = trim(company);
  --------------------------------
  select distinct industry
  from layoffs_staging2
  order by 1;
  
  select*
  from layoffs_staging2
  where industry like 'Crypto%';
  
  update layoffs_staging2 
  set industry = 'Crypto'
  where industry like 'Crypto%';
  
  select*
  from layoffs_staging2
  where industry like 'Crypto%';
  
  select distinct industry
  from layoffs_staging2;  
  
  -- correct-finish--

--------------------------------------
select distinct location
from layoffs_staging2;

-- correct-finish--

------------------------------------------
select distinct country
from layoffs_staging2;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

-- for deleting a '.' from the united states--

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

-- correct-finish--
  ------------------------------------------------------------
  
  select `date`,
  str_to_date(`date` , '%m/%d/%Y')
  FROM layoffs_staging2;
  
  UPDATE layoffs_staging2
  SET `date` =   str_to_date(`date` , '%m/%d/%Y');
  
  ALTER TABLE layoffs_staging2
  modify column `date` DATE;

 -- CORRECT-FINISH--;

----------------------------------------------------------------
 -- 3. Look at Null Values

-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. I don't think I want to change that
-- I like having them null because it makes it easier for calculations during the EDA phase

-- so there isn't anything I want to change with the null values

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'airbnb%';

-- we should set the blanks to nulls since those are typically easier to work with

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- now if we check those are all null

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- CORRECT-FINISH--
------------------------------------------------------

-- 4. remove any columns and rows we need to

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;
  
  SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
  
  
  -- Delete Useless data we can't really use 
  
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


  SELECT *
  FROM layoffs_staging2;
  
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- CORRECT-FINISH
----------------------------------------------------------
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  