# Tendu Supply Chain Analytics

An end-to-end supply chain analytics project analysing tendu leaf procurement, quality inspection, inventory, transportation, sales, payments and operating performance using Excel, PostgreSQL, Python and Power BI.

## Project Overview

This project was developed to demonstrate how data can be transformed into actionable business insights across a complete supply chain.

The analysis follows the journey of tendu leaves from forest procurement through collection, quality inspection, bundling, transportation and warehouse inventory, followed by sales, payments and expense analysis.

The project combines relational database design, data quality validation, SQL analysis, Python-based analytics and interactive Power BI reporting.

## Business Context

The supply chain involves multiple interconnected activities:

**Forest Procurement → Collection → Quality Inspection → Bundling → Transportation → Warehouse Inventory → Sales → Payments**

The dataset represents a structured supply chain environment containing information about forests, contracts, labourers, collection activities, quality inspections, bundles, warehouses, transportation, inventory, buyers, sales, payments and expenses.

The project focuses on understanding operational performance, procurement patterns, quality outcomes, costs, sales performance and profitability.

## Objectives

The main objectives of the project are to:

- Validate the quality and integrity of the supply chain database
- Analyse procurement and collection patterns over time
- Identify forests contributing to procurement
- Analyse contracts, expenses and operating performance
- Examine sales and revenue trends
- Analyse buyer sales and payment performance
- Evaluate quality acceptance and rejection rates
- Analyse warehouse capacity and inventory utilisation
- Segment buyers, forests, labourers and quality inspections
- Apply advanced SQL techniques to support business analysis
- Develop an interactive Power BI dashboard for decision support

## Technology Stack

- **Excel** – Dataset preparation and initial data organisation
- **PostgreSQL / pgAdmin** – Relational database implementation and SQL analysis
- **Python** – Data analysis and analytical exploration
- **Power BI** – Interactive dashboards and business reporting
- **GitHub** – Project documentation and version-controlled project structure

## Dataset

The project database contains 13 interconnected tables:

| Table | Description |
|---|---|
| `forests` | Forest and procurement-location information |
| `contracts` | Forest procurement contracts |
| `labourers` | Labourer and workforce information |
| `collection` | Tendu leaf collection records |
| `quality_inspection` | Quality inspection and accepted/rejected quantities |
| `bundles` | Bundled leaf records |
| `warehouses` | Warehouse information and capacity |
| `transportation` | Transportation and delivery records |
| `inventory` | Warehouse inventory records |
| `buyers` | Buyer information |
| `sales` | Sales transactions |
| `payments` | Buyer payment records |
| `expenses` | Contract-related and operating expenses |

The dataset contains records covering the major stages of the supply chain and is structured to support relational analysis across procurement, operations, finance and sales.

## Data Quality & Validation

The SQL analysis begins with database validation to ensure the reliability of subsequent analysis.

The validation includes:

- Record-count validation across all tables
- Primary-key uniqueness and duplicate checks
- NULL-value checks for key identifiers
- Data-type and column-structure validation
- Foreign-key integrity checks
- Orphan-record detection
- Date-integrity constraints
- Business-rule validation using SQL constraints

Examples include checking relationships such as:

- Collection → Contracts
- Collection → Forests
- Collection → Labourers
- Quality Inspection → Collection
- Bundles → Quality Inspection
- Inventory → Warehouses
- Sales → Buyers
- Sales → Bundles
- Sales → Transportation
- Payments → Sales

## SQL Analysis

The SQL component is organised into separate analytical sections.

### 1. Data Quality Analysis

Queries are used to validate:

- Table structure
- Record counts
- Primary-key uniqueness
- Duplicate or NULL identifiers
- Foreign-key integrity
- Date constraints and business rules

### 2. Basic Business Analysis

The analysis examines:

- Procurement trends over time
- Total and average collection quantities
- Forest-level procurement contribution
- Expense categories and monthly expense trends
- Estimated forest-level operating profit
- Selling price and revenue by leaf grade
- Monthly sales and revenue trends

### 3. Join Analysis

Multi-table joins are used to analyse:

- Collection across forests
- Contract value and expenses
- Contract value and actual yield
- Buyer revenue and outstanding payments
- Quality acceptance and rejection by forest
- Expense-to-contract ratios

### 4. Business KPI Analysis

Key performance indicators include:

- Average procurement cost per kg
- Average selling price per kg
- Collection acceptance rate
- Forest-level revenue and operating profit
- Outstanding receivables
- Profit margin
- Buyer sales and payment performance

### 5. Case Analysis

Business-rule based classifications are applied to:

- Contract value
- Contract profitability
- Warehouse capacity risk

### 6. Segmentation Analysis

The project applies rule-based segmentation to:

- Buyer revenue
- Forest procurement performance
- Labour productivity
- Quality inspection outcomes

### 7. Advanced SQL Analysis

Advanced PostgreSQL techniques include:

- Common Table Expressions (CTEs)
- Window functions
- `RANK()`
- `LAG()`
- Running totals
- Multi-stage aggregations
- Conditional classification using `CASE`
- Multiple-table joins
- Analytical calculations

Examples include buyer revenue ranking, forest procurement ranking, cumulative sales revenue, sale-to-sale comparison and warehouse efficiency analysis.

## Python Analysis

The `python` folder contains the Python-based analytical component of the project.

Python is used to extend the database analysis through data handling, exploration and analytical processing using a data-analysis workflow.

The Python component complements the PostgreSQL analysis by providing an additional environment for examining patterns and preparing analytical outputs.

## Power BI Dashboard

The `PowerBI` folder contains the interactive business intelligence component of the project.

The dashboard converts the underlying supply chain data into visual reports covering areas such as:

- Executive business performance
- Procurement and collection
- Quality performance
- Transportation and operations
- Sales and financial performance
- Inventory and operational indicators

The dashboard is designed to allow users to explore supply chain performance through interactive visualisations and KPIs.

## Data Model

An Entity Relationship Diagram (ERD) is included in the root directory to illustrate the relationships between the project's 13 database tables.

Files:

- `ERD.png` – Visual ER diagram
- `ERD.json` – ER diagram structure

## Repository Structure

Tendu-Supply-Chain-Analytics/
│
├── PowerBI/
│   ├── Dashboard_Overview.png
│   ├── PowerBI_Dashboard.pdf
│   ├── Tendu_Supply_Chain_Analytics.pbix
│   └── README.md
│
├── SQL/
│   ├── 01_Data_Quality.sql
│   ├── 02_Basic_Business_Analysis.sql
│   ├── 03_JOIN_Analysis.sql
│   ├── 04_Business_KPIs.sql
│   ├── 05_CASE_1_Analysis.sql
│   ├── 06_Segmentation_Analysis.sql
│   └── 07_Advanced_SQL_Analysis.sql
│
├── python/
│   ├── Tendu_Leaf_Python_Analysis.ipynb
│   └── README.md
│
├── ERD.png
├── ERD.json
├── Tendu_Supply_Chain_Dataset.xlsx
└── README.md
└── README.md
