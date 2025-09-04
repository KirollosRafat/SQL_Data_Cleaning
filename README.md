# Layoffs Data Cleaning & Standardization (MySQL) 🚀

![MySQL Badge](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![SQL Badge](https://img.shields.io/badge/SQL-FC0D1B?style=flat&logo=sql&logoColor=white)

## Overview ✨
This project demonstrates a **data cleaning and standardization workflow using MySQL** on a dataset of company layoffs. The goal is to **prepare a clean, consistent dataset** suitable for analysis or reporting.

Using this project, you can:
- 🧹 Remove duplicate records.
- 📝 Standardize text fields (company names, industry, country).
- 📅 Convert date strings to proper `DATE` format.
- ❌ Handle missing and null values systematically.
- 🛠️ Clean irrelevant or incomplete records.

---

## Dataset 📊
The dataset, `layoffs`, contains the following columns:

| Column | Description |
|--------|-------------|
| company | Company name |
| location | Location of layoffs |
| industry | Company industry |
| total_laid_off | Total number of employees laid off |
| percentage_laid_off | Percentage of workforce laid off |
| date | Date of layoff event |
| stage | Company stage (Startup, Series A, etc.) |
| country | Country |
| funds_raised_millions | Funds raised in millions |

*Note: The dataset may contain duplicates, blanks, inconsistent formats, and null values.*

---

## Steps Performed 🛠️
1. **Staging Table Creation** – Created a staging table and inserted raw data.  
2. **Duplicate Removal** – Used `ROW_NUMBER()` with `PARTITION BY` to identify duplicates and delete them.  
3. **Data Standardization** – Trimmed spaces, standardized industries and countries, converted `date` to `DATE`.  
4. **Handling Nulls and Blanks** – Replaced empty strings with `NULL`, propagated missing data where possible, and deleted rows with missing layoffs info.  
5. **Final Cleanup** – Dropped temporary columns (`row_num`) and ensured the dataset is ready for analysis.  

---

## SQL Script 💾
All cleaning steps are implemented in a **single comprehensive SQL script**:

```text
DataCleaningProject.sql
```

- Run this script in MySQL to perform the full cleaning workflow.  
- The script handles duplicates, standardization, nulls, and final cleanup automatically.

---

## Usage ▶️
1. Clone this repository:
   ```bash
   git clone https://github.com/KirollosRafat/SQL_Data_Cleaning.git
   ```
2. Load the `layoffs` dataset into MySQL.
3. Run the script:
   ```sql
   SOURCE DataCleaningProject.sql;
   ```
4. Query the final cleaned table:
   ```sql
   SELECT * FROM staging2;
   ```

---

## Outcome ✅
After running the script:
- Duplicates removed ✅  
- Text fields standardized ✅  
- Dates converted to proper `DATE` format ✅  
- Missing values handled ✅  
- Dataset ready for analysis ✅  

---

## Optional Improvements 🌟
- Add automated scripts for batch processing.  
- Integrate with Python or R for further analysis.  
- Create visualizations of layoffs trends over time.

