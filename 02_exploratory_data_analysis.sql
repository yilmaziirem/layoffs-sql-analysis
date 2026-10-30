-- Layoffs exploratory data analysis
-- Guided project based on Alex The Analyst's bootcamp.
-- Requires the cleaned layoffs_staging2 table.
-- Date-based analyses cover a partial 2023, ending on March 6.

USE world_layoffs;


SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH` 
ORDER BY 1 ASC ;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH` 
ORDER BY 1 ASC 
)
SELECT `MONTH`, total_off,
 SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total
;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC ;

-- Reported layoffs by company and year; excludes missing dates.
SELECT
    company,
    YEAR(`date`) AS layoff_year,
    SUM(total_laid_off) AS reported_layoffs
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY company, YEAR(`date`)
ORDER BY reported_layoffs DESC, company, layoff_year;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year 
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank 
WHERE Ranking <= 5 
ORDER BY years, Ranking, company;

-- Reported layoffs by year; excludes records with missing dates.
SELECT
    YEAR(`date`) AS layoff_year,
    SUM(total_laid_off) AS reported_layoffs
FROM world_layoffs.layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY layoff_year;

-- Top 10 companies by total reported layoffs.
SELECT
    company,
    SUM(total_laid_off) AS reported_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY reported_layoffs DESC, company
LIMIT 10;