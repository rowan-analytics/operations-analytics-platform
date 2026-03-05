/*
Step: Time Series Analysis
Goal: Analyze revenue trends over time
*/

SELECT
    strftime('%Y-%m', clean_date) AS month,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM sales_clean
GROUP BY 1
ORDER BY 1;
