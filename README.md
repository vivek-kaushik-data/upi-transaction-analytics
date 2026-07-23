# UPI Transaction Analytics | SQL + Power BI

## Project Overview
An end-to-end data analysis project on NPCI-published UPI transaction data 
covering 50 months (April 2022 to February 2026). The project analyzes 
app-wise transaction volume and value trends across 3,472 records using 
Python for data cleaning, MySQL for business analysis, and Power BI for 
interactive dashboards.

## Dataset
- Source: NPCI Official Statistics (via Kaggle — Nilesh Kadam)
- Size: 3,472 rows × 6 columns
- Time Period: April 2022 — February 2026
- Columns: app_name, total_volume_mn, total_value_cr, month, year, category

## Tools Used
- Python (Pandas) — Data extraction, cleaning, and combining 50 Excel files
- MySQL — Business question analysis using window functions, CTEs, subqueries
- Power BI — Interactive dashboard (In Progress)

## Business Questions Answered
1. Which month had the highest and lowest UPI transaction volume?
2. What is the year-over-year growth rate in UPI transactions?
3. Which are the top 5 apps by total transaction volume?
4. Do Payment Apps or Bank Apps dominate UPI transactions?
5. Which apps process the highest average value per transaction?
6. Which apps are new market entrants (2025-2026)?
7. Is there a seasonal pattern in UPI transaction volumes?
8. What is each app's percentage share in total UPI volume?
9. Which apps grew the fastest between 2022 and 2025?
10. Which apps consistently ranked in the top 10 every year?

## Key Findings
- Google Pay controls 52.79% of total UPI transaction volume — a clear market leader
- Payment Apps process 11x more volume than Bank Apps
- UPI transactions peak in April and May driven by new financial year activity
- 13 new apps entered the UPI ecosystem in 2025-2026 showing continued expansion
- Only 5 apps maintained consistent top 10 ranking across all 4 years
- UPI volume declined in 2025 coinciding with regulatory actions on major payment players

## Project Structure
upi-transaction-analytics/
├── data/
│   └── upi_apps_combined.csv
├── sql/
│   └── upi_apps_analysis.sql
├── dashboard/
│   └── upi_dashboard.pbix (In Progress)
└── README.md

## How to Run
1. Clone this repository
2. Import upi_apps_combined.csv into MySQL
3. Run upi_apps_analysis.sql in MySQL Workbench
4. Power BI dashboard coming soon
