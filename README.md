# Layoffs Data Cleaning & Analysis with MySQL

A guided SQL project based on Alex The Analyst's Data Analyst Bootcamp, covering data cleaning and exploratory analysis of a layoffs dataset.

## Project objectives

- Prepare raw data for analysis.
- Explore reported layoffs over time.
- Identify companies with the highest reported layoffs.
- Rank companies by reported layoffs within each year.

## Tools and techniques

MySQL 8 and MySQL Workbench.

Techniques include CTEs, self joins, aggregate functions, date conversion, ROW_NUMBER, DENSE_RANK and cumulative totals.

## Files

| File | Purpose |
| --- | --- |
| [01_data_cleaning.sql](01_data_cleaning.sql) | Create working copies, remove duplicates, standardize values, handle missing data and convert dates. |
| [02_exploratory_data_analysis.sql](02_exploratory_data_analysis.sql) | Analyze monthly and yearly totals, cumulative layoffs and company rankings. |

## Data cleaning

- Preserved the original `layoffs` table by using staging tables.
- Removed duplicate records based on all nine original fields.
- Trimmed company names and standardized selected industry and country values.
- Converted the date column from text to DATE.
- Filled missing industries using available records for the same company.
- Removed records where both layoff count and percentage were missing.
- Removed the temporary `row_num` column.

## Key findings

Results below were checked against the existing cleaned table in MySQL Workbench.

- The cleaned table contains **1,995 records**.
- Total reported layoffs: **383,659**.
- Dated records range from **March 11, 2020 to March 6, 2023**.
- One undated Blackbaud record accounts for **500** reported layoffs.
- **2022** has the highest annual total in the dataset: **160,661**.
- **Amazon** has the highest company total: **18,150**.

### Reported layoffs by year

| Year | Reported layoffs |
| --- | ---: |
| 2020 | 80,998 |
| 2021 | 15,823 |
| 2022 | 160,661 |
| 2023, through March 6 | 125,677 |

The yearly totals exclude the undated record and sum to **383,159**.

## Limitations

- This dataset is a historical snapshot, not a complete count of worldwide layoffs.
- The first and last years cover partial periods; annual totals are not directly comparable as full calendar years.
- Missing layoff counts are excluded by SUM and are not treated as zero.
- The undated record is retained in overall and company totals but excluded from date-based analyses.
- DENSE_RANK includes ties, so the top five ranks may contain more than five companies.

## How to use

The raw dataset is not included in this repository.

1. Import the bootcamp's original `layoffs.csv` into a table named `layoffs` in the `world_layoffs` schema.
2. Check that its column order and types match the cleaning script.
3. Run `01_data_cleaning.sql` once in a fresh setup where `layoff_staging` and `layoffs_staging2` do not already exist.
4. Run `02_exploratory_data_analysis.sql` against the cleaned table.

The EDA script was run successfully in MySQL Workbench. The complete cleaning script has not yet been retested from a fresh import.

## Acknowledgements

Based on the guided layoffs project from [Alex The Analyst](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series).

I followed the bootcamp project and reviewed table naming, missing-value processing order, ranking filters and analysis results while preparing this repository.
