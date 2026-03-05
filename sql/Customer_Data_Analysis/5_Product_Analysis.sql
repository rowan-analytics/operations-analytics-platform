/*
Step: Product Analysis
Goal: Identify best selling products
*/

SELECT
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM Online_retails_data
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;
