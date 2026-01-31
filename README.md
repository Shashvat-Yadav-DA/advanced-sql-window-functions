# Task 8 – SQL Window Functions

## Project Overview
This project is part of the **Data Analyst Internship Task 8**. The goal of this task is to practice SQL window functions such as `ROW_NUMBER`, `RANK`, `DENSE_RANK`, running totals, and Month-over-Month (MoM) growth using an e-commerce sales dataset. All operations were performed using **PostgreSQL**.

## Dataset
The analysis is based on the **Online Retail dataset**.
* **Main columns used:** `InvoiceNo`, `StockCode`, `Quantity`, `InvoiceDate`, `UnitPrice`, `CustomerID`, `Country`.
* **Sales Calculation:** $Quantity \times UnitPrice$

## Tasks Performed
* **Data Import:** Processed and imported the CSV file into PostgreSQL with correct data types.
* **Customer Analysis:** Calculated total sales per customer using `GROUP BY`.
* **Ranking:** Ranked customers by sales within each country using `ROW_NUMBER`.
* **Tie Handling:** Compared `RANK` and `DENSE_RANK` to understand behavior during sales ties.
* **Running Totals:** Calculated cumulative sales totals using window functions.
* **Growth Metrics:** Calculated Month-over-Month (MoM) sales growth using the `LAG` function.
* **Reporting:** Identified top customers and exported results to CSV for stakeholder review.
* **Insights:** Documented key business findings based on the data trends.

## Files in This Repository
* `task8_window.sql`: Contains all SQL queries used in this task.
* `ranked_customers.csv`: Exported file showing customer ranking by country.
* `mom_growth.csv`: Exported file showing Month-over-Month sales growth.
* `insights_task8.txt`: Business insights written in simple, actionable language.
* `README.md`: Project explanation and summary.

## Tools Used
* **Database:** PostgreSQL
* **Management:** pgAdmin
* **Techniques:** SQL Window Functions (OVER, PARTITION BY, LAG)

## Key Learnings
* Advanced application of **Window Functions** in real-world scenarios.
* The functional difference between `ROW_NUMBER`, `RANK`, and `DENSE_RANK`.
* Calculating **Running Totals** for trend analysis.
* Performing time-series analysis like **Month-over-Month growth** using `LAG`.
* Exporting query results to CSV for professional reporting.

---
*This task provided hands-on experience with advanced SQL reporting techniques used in real-world data analysis.*
