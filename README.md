# Banking Credit Risk Analysis

An end-to-end credit risk analysis project using **Python, SQL/MySQL, and Power BI** to understand loan portfolio risk, borrower behavior, default patterns, and financial exposure.

## Project Overview

The objective of this project was to analyze a large loan portfolio and answer a practical business question:

> **Which borrower and loan characteristics are associated with higher credit risk, and where is the bank's financial exposure concentrated?**

The project combines data preparation, SQL analysis, exploratory analysis, KPI calculation, risk segmentation, and interactive Power BI reporting.

## Key Results

| KPI | Result |
|---|---:|
| Total Loans | **1,347,681** |
| Total Loan Exposure | **$19.42B** |
| Average Loan Amount | **$14,408.23** |
| Overall Default Rate | **19.98%** |
| Defaulted Loans | **269,249** |
| Defaulted Exposure | **$4.19B** |

## Key Insights

- Borrowers with **FICO below 650** had an observed default rate of **32.03%**, compared with **8.88%** for the **750+** FICO group.
- Borrowers with **DTI above 40%** had an observed default rate of approximately **30.71%**, while the **below 10%** group was approximately **14.84%**.
- The **High Risk** segment had an observed default rate of about **30.75%**, compared with **7.85%** for the **Low Risk** segment.
- **Debt consolidation** represented the largest share of portfolio exposure, at approximately **61.25%** of total loan exposure.
- The analysis shows why credit risk should be evaluated using both **default rate** and **financial exposure**, rather than relying on a single metric.

> **Note:** These are observed relationships in the analyzed dataset and should not be interpreted as proof that one factor directly causes default.

## Tools & Technologies

- **Python** — data cleaning, transformation, exploratory analysis, KPI calculations
- **Pandas / NumPy** — data manipulation and analysis
- **SQL / MySQL** — querying, aggregation, and structured analysis
- **Power BI** — interactive dashboard and data visualization
- **Jupyter Notebook** — analysis workflow
- **Git / GitHub** — version control and project management

## Project Workflow

```text
Raw Loan Data
     │
     ▼
Data Cleaning & Preparation
     │
     ▼
Feature Grouping
(FICO, DTI, Loan Size, Risk Category)
     │
     ▼
Python Analysis
     │
     ▼
SQL / MySQL Analysis
     │
     ▼
KPI & Risk Analysis
     │
     ▼
Power BI Dashboard
     │
     ▼
Business Insights
```

## Power BI Dashboard

The project contains a **4-page interactive Power BI dashboard**:

### 1. Overview
- Total Loans
- Total Loan Exposure
- Average Loan Amount
- Overall Default Rate
- Default Rate by FICO Group
- Default Rate by DTI Group
- Default Rate by Loan Purpose

### 2. Risk Analysis
- Loan Exposure Trend by Year
- Loan Exposure by Purpose
- Default Rate by Risk Category
- Loan Exposure by Loan Group

### 3. Customer Analysis
- Default Rate by Home Ownership
- Default Rate by Employment Length

### 4. Geographic Analysis
- Loan Exposure by State
- Default Rate by State
- State-level portfolio risk analysis

## Project Structure

```text
Banking-Credit-Risk-Analysis/
│
├── notebooks/
│   └── 01_data_understanding.ipynb
│
├── sql/
│   ├── 01_banking_credit_risk_analysis.sql
│   ├── 01_data_setup.ipynb
│   └── import_to_mysql.py
│
├── power bi/
│   └── Banking_Credit_Risk_Analysis_Dashboard.pbix
│
├── data/
│   └── (dataset files excluded from GitHub)
│
└── .gitignore
```

## Data

The analysis was performed on a cleaned loan dataset containing **1.35M+ records**.

The large CSV dataset is intentionally **not included in this GitHub repository** to keep the repository lightweight and avoid unnecessarily storing a very large data file.

## Example Business Questions

This project was designed to answer questions such as:

- What is the overall default rate?
- Which FICO groups have the highest default risk?
- How does DTI relate to observed default rate?
- Which loan purposes carry higher observed risk?
- Which risk categories have the highest default rates?
- Where is the largest loan exposure concentrated?
- How does portfolio exposure change over time?
- Which customer characteristics are associated with different default rates?

## Future Improvements

Possible next steps would be to move from descriptive analysis to predictive risk modeling:

- Build a **probability-of-default model**
- Compare Logistic Regression with tree-based models
- Evaluate models using **ROC-AUC, precision, recall, and confusion matrix**
- Add probability-of-default scoring to the Power BI dashboard
- Develop an early-warning framework for high-risk borrowers

## Resume Project

**Banking Credit Risk Analysis | Python, SQL, Power BI**

- Analyzed **1.35M+ loan records and $19.42B in loan exposure** to identify borrower risk patterns and portfolio-level default trends.
- Built a **4-page interactive Power BI dashboard** covering FICO/DTI segmentation, loan purpose, customer demographics, risk categories, and geographic analysis.
- Identified a **32.03% observed default rate for FICO <650 vs. 8.88% for the 750+ group**, supporting data-driven credit risk assessment.

## Disclaimer

This project is intended for **educational and portfolio purposes**. The findings are based on historical data and should not be treated as a production credit decisioning system.
