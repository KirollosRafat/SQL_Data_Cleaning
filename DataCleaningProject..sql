SELECT *
FROM layoffs;
CREATE TABLE staging
LIKE layoffs;  

# Create a staging table similar to the raw database
INSERT staging
SELECT *
FROM layoffs;

SELECT *
FROM staging
WHERE company = 'Cazoo';

-- Cleaning Steps
-- 1. Remove duplicates.
-- 2. Data Standarization.
-- 3. Null and Blanks Handling.
-- 4. Remove and clean any irrelevant. 

WITH duplicate_CTE AS
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM staging
)
SELECT *
FROM duplicate_CTE
WHERE row_num >= 2;


CREATE TABLE `staging2` (
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

INSERT INTO staging2
SELECT *,ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM staging;

SET SQL_SAFE_UPDATES = 0;

DELETE
FROM staging2
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM staging2;

# Now, We have removed all duplicates

-- Data Standarization
SET SQL_SAFE_UPDATES = 0;

UPDATE staging2
SET comapny = TRIM(company);

SELECT DISTINCT industry
FROM staging2
ORDER BY 1;

UPDATE staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM staging2
ORDER BY 1;

UPDATE staging2
SET country = 'USA'
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM staging2
ORDER BY 1;

SELECT `date` ,STR_TO_DATE(`date`,'%m/%d/%Y') AS date_standard
FROM staging2;

UPDATE staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

SELECT *
FROM staging2;

-- Handling Nulls and Blank Values


SELECT *
FROM staging2
WHERE industry IS NULL
OR industry = ''; 

## We should try populate the blanks and the missing data fields (NULLs)

UPDATE staging2 
SET industry = NULL
WHERE industry = '';

SELECT *
FROM staging2 t1
JOIN staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry = '' ) AND t2.industry IS NOT NULL;

UPDATE staging2 t1
JOIN staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry = '' ) AND t2.industry IS NOT NULL;

SELECT *
FROM staging2 
WHERE company LIKE 'Bally%';

SELECT COUNT(*) # 361 rows of NULL values of total_laid_off and percentage_laid_off
FROM staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

# Deleting these rows seems the right thing to do
DELETE 
FROM staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

SELECT *
FROM staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

# We will drop the row_num column
ALTER TABLE staging2
DROP COLUMN row_num;

SELECT *
FROM staging2;




