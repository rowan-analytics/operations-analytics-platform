/*
Step: Customer Analysis
Goal: Identify highest value customers
*/

SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM Online_retails_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY revenue DESC
LIMIT 10;
