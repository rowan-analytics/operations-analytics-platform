-- Weekly KPI Report
-- Purpose: Core performance metrics for retail operations

SELECT
    DATE_TRUNC('week', order_date) AS week_start,
    COUNT(DISTINCT order_id)        AS total_orders,
    SUM(revenue)                    AS total_revenue,
    AVG(delivery_days)              AS avg_delivery_time,
    SUM(CASE WHEN on_time = 1 THEN 1 ELSE 0 END) * 1.0 
        / COUNT(*)                  AS on_time_delivery_rate
FROM fact_orders
GROUP BY 1
ORDER BY week_start;

