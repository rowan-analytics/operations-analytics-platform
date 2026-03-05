
/*
Project: Retail Sales Analytics
Step: Data Exploration
Goal: Understand structure, size, and missing values
*/

-- preview dataset
SELECT *
FROM Online_retails_data
LIMIT 10;

-- dataset size
SELECT COUNT(*) AS total_rows
FROM Online_retails_data;

-- unique orders & customers
SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers
FROM Online_retails_data;

-- check missing customers
SELECT COUNT(*)
FROM Online_retails_data
WHERE CustomerID IS NULL;
