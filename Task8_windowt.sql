CREATE TABLE sales (
    invoice_no   VARCHAR,
    stock_code   VARCHAR,
    description  TEXT,
    quantity     INT,
    invoice_date TIMESTAMP,
    unit_price   NUMERIC(10,2),
    customer_id  INT,
    country      VARCHAR
);

SELECT *FROM sales;


SELECT
    customer_id,
    SUM(quantity * unit_price) AS total_sales
FROM sales
GROUP BY customer_id;


SELECT
    country,
    customer_id,
    SUM(quantity * unit_price) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY SUM(quantity * unit_price) DESC
    ) AS row_number
FROM sales
GROUP BY country, customer_id;



SELECT
    country,
    customer_id,
    SUM(quantity * unit_price) AS total_sales,
    RANK() OVER (
        PARTITION BY country
        ORDER BY SUM(quantity * unit_price) DESC
    ) AS rank_val,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY SUM(quantity * unit_price) DESC
    ) AS dense_rank_val
FROM sales
GROUP BY country, customer_id;




SELECT
    invoice_date::date AS order_date,
    SUM(quantity * unit_price) AS daily_sales,
    SUM(SUM(quantity * unit_price)) OVER (
        ORDER BY invoice_date::date
    ) AS running_total
FROM sales
GROUP BY invoice_date::date
ORDER BY order_date;




WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS month,
        SUM(quantity * unit_price) AS monthly_sales
    FROM sales
    GROUP BY DATE_TRUNC('month', invoice_date)
)
SELECT
    month,
    monthly_sales,
    monthly_sales - LAG(monthly_sales) OVER (ORDER BY month) AS mom_change,
    ROUND(
        (monthly_sales - LAG(monthly_sales) OVER (ORDER BY month))
        / LAG(monthly_sales) OVER (ORDER BY month) * 100, 2
    ) AS mom_growth_pct
FROM monthly_sales;


WITH ranked_products AS (
    SELECT
        country AS category,
        stock_code,
        description,
        SUM(quantity * unit_price) AS product_sales,
        DENSE_RANK() OVER (
            PARTITION BY country
            ORDER BY SUM(quantity * unit_price) DESC
        ) AS rank_no
    FROM sales
    GROUP BY country, stock_code, description
)
SELECT *
FROM ranked_products
WHERE rank_no <= 3;



CREATE VIEW ranked_customers AS
SELECT
    country,
    customer_id,
    SUM(quantity * unit_price) AS total_sales,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY SUM(quantity * unit_price) DESC
    ) AS rank_no
FROM sales
GROUP BY country, customer_id;



copy (
    SELECT
        country,
        customer_id,
        SUM(quantity * unit_price) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY country
            ORDER BY SUM(quantity * unit_price) DESC
        ) AS rank_no
    FROM sales
    GROUP BY country, customer_id
) TO 'C:/Users/Public/ranked_customers.csv' CSV HEADER;


COPY (
    WITH monthly_sales AS (
        SELECT
            DATE_TRUNC('month', invoice_date) AS month,
            SUM(quantity * unit_price) AS monthly_sales
        FROM sales
        GROUP BY DATE_TRUNC('month', invoice_date)
    )
    SELECT
        month,
        monthly_sales,
        monthly_sales 
            - LAG(monthly_sales) OVER (ORDER BY month) AS mom_change,
        ROUND(
            (
                monthly_sales 
                - LAG(monthly_sales) OVER (ORDER BY month)
            ) 
            / LAG(monthly_sales) OVER (ORDER BY month) * 100,
            2
        ) AS mom_growth_percentage
    FROM monthly_sales
    ORDER BY month
) TO 'C:/Users/Public/mom_growth.csv' CSV HEADER;



