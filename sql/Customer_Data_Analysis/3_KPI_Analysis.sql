/*
Step: KPI Analysis
Goal: Calculate revenue and order metrics
*/

SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    ROUND(SUM(Quantity * UnitPrice),2) AS total_revenue,
    ROUND(AVG(Quantity * UnitPrice),2) AS avg_order_value
FROM Online_retails_data
WHERE Quantity > 0;
