-- ========================================
-- Retail Sales Data Exploration
-- ========================================

-- View sample of the dataset
SELECT *
FROM online_retails_data
LIMIT 10;

------------------------------------------------

-- Count total rows
SELECT COUNT(*) AS total_rows
FROM online_retails_data;

------------------------------------------------

-- Check column data types and structure
DESCRIBE online_retails_data;

------------------------------------------------

-- Check for missing values
SELECT
    SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS missing_invoice,
    SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS missing_stockcode,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS missing_description,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS missing_unitprice,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customer,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS missing_country
FROM online_retails_data;

------------------------------------------------

-- Check date range of dataset
SELECT
    MIN(InvoiceDate) AS first_transaction,
    MAX(InvoiceDate) AS last_transaction
FROM online_retails_data;

------------------------------------------------

-- Number of unique customers
SELECT
    COUNT(DISTINCT CustomerID) AS unique_customers
FROM online_retails_data;

------------------------------------------------

-- Number of unique products
SELECT
    COUNT(DISTINCT StockCode) AS unique_products
FROM online_retails_data;

------------------------------------------------

-- Countries present in dataset
SELECT
    Country,
    COUNT(*) AS transactions
FROM online_retails_data
GROUP BY Country
ORDER BY transactions DESC;

------------------------------------------------

-- Top selling products by quantity
SELECT
    Description,
    SUM(Quantity) AS total_units_sold
FROM online_retails_data
GROUP BY Description
ORDER BY total_units_sold DESC
LIMIT 10;

------------------------------------------------

-- Revenue calculation preview
SELECT
    Description,
    SUM(Quantity * UnitPrice) AS revenue
FROM online_retails_data
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

------------------------------------------------

-- Orders per country
SELECT
    Country,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retails_data
GROUP BY Country
ORDER BY total_orders DESC;

------------------------------------------------

-- Customer purchasing behaviour
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS orders,
    SUM(Quantity * UnitPrice) AS total_revenue
FROM online_retails_data
GROUP BY CustomerID
ORDER BY total_revenue DESC
LIMIT 10;
