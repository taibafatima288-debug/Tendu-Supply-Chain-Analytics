# Python Analysis

This folder contains the Python analysis developed as part of the **Tendu Leaf Supply Chain Analytics** project.

The Python stage extends the SQL analysis through exploratory data analysis, statistical analysis, relationship analysis, outlier detection and data visualisation.

## Notebook

**Tendu_Leaf_Python_Analysis.ipynb**

The notebook connects to the PostgreSQL database and uses Python to analyse selected operational, financial and quality-related data.

## Analysis Areas

The notebook covers:

- PostgreSQL data connection and data loading
- Data inspection and validation
- Descriptive statistics
- Procurement and collection analysis
- Sales and revenue analysis
- Expense and operating surplus analysis
- Buyer revenue analysis
- Quality and leaf-grade analysis
- Correlation and relationship analysis
- IQR-based outlier detection
- Data visualisation
- Business interpretation of analytical findings
- Preparation of analytical datasets for Power BI

## Visualisations

The analysis includes visualisations of:

- Monthly procurement trends
- Monthly sales revenue
- Monthly operating surplus
- Sales revenue distribution
- Quantity sold vs. sales revenue
- Expenses vs. operating surplus
- Leaf-grade distribution
- Leaf moisture distribution

## Power BI Preparation

The Python analysis also prepares analytical datasets for the final Power BI reporting stage, including:

- Monthly procurement data
- Monthly revenue and expense data
- Buyer revenue data
- Quality and leaf-grade data
- Sales-level data

This creates a connection between the Python analytical stage and the final Power BI dashboard.

## Tools & Technologies

- Python
- Pandas
- Matplotlib
- PostgreSQL
- psycopg2
- Jupyter Notebook

## Project Workflow

**Excel → ERD & Database Design → PostgreSQL → SQL Analysis → Python Analysis → Power BI**

The Python analysis builds on the structured PostgreSQL data and complements the SQL analysis by providing additional statistical, exploratory and visual analysis.

## Project Context

The project models a tendu leaf procurement and supply-chain business covering forest procurement, leaf collection, quality inspection, inventory, transportation, sales and financial transactions.

The Python analysis provides additional analytical insights into these operational and business processes.
