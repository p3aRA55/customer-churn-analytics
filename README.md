# Retail Customer Churn Analytics

Analysis of online retail customer behavior and churn prediction, with an executive decision-support dashboard in Power BI.

## Problem

Which customers are likely to stop purchasing, and why? This project builds an end-to-end analytics pipeline — from raw transaction data to a churn prediction model and a management-facing dashboard — that mirrors the workflow of a real Data Science team.

## Dataset

[Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii) (UCI) — ~1M+ transactions from a UK-based online retailer over two years.

Fields: `Invoice`, `CustomerID`, `Product`, `Quantity`, `Price`, `Country`, `Date`

## Project Structure

```
retail-customer-churn-analytics/
├── data/
│   ├── raw/            # Original, immutable dataset
│   └── processed/       # Cleaned/transformed data
├── sql/                # Schema, queries, views
├── notebooks/          # EDA, cohort/RFM, modeling notebooks
├── src/                # Reusable Python modules (cleaning, features, models)
├── models/             # Serialized trained models
├── reports/
│   └── figures/         # Exported charts/visuals
├── powerbi/             # .pbix dashboard file(s)
└── docs/                # Data dictionary, methodology notes
```

## Pipeline

1. **Data Collection** — download, inspect, load into SQL
2. **Database Design** — schema, keys, indexes, views
3. **Data Cleaning** — missing values, duplicates, outliers, refunds
4. **EDA** — trends, correlation, seasonality
5. **Cohort & RFM Analysis** — retention, segmentation
6. **Statistical Testing** — hypothesis tests across segments
7. **Feature Engineering** — RFM, LTV, purchase behavior features
8. **Machine Learning** — churn classification (Logistic Regression, Random Forest, etc.)
9. **Power BI Dashboard** — Executive, Customer, Product, Geographic, Churn views

## Tech Stack

SQL (PostgreSQL) · Python (pandas, scikit-learn) · Power BI

## Team

| | Role focus |
|---|---|
| Parsa Azaryoun | Analytical queries, EDA insights, RFM, modeling, hypothesis testing |
| Teammate | Schema design, data validation, visualization, dashboard implementation |

## Status

🚧 In progress
