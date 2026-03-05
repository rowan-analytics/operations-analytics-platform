/*
Project: Retail Sales Analytics
Step: SQL Views & Automation
Goal: Create reusable reporting views for dashboards and analytics
Dataset: Online_retails_data
*/


/* ---------------------------------------------------
Create Clean Sales View
Removes returns, invalid prices, and missing customers
--------------------------------------------------- */

CREATE VIEW sales_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    UnitPrice,
    CustomerID,
    InvoiceDate,
    DATE(InvoiceDate) AS clean_date
FROM Online_retails_data
WHERE Quantity > 0
AND UnitPrice > 0
AND CustomerID IS NOT NULL;



/* ---------------------------------------------------
Monthly Revenue View
Used for revenue reporting and dashboards
--------------------------------------------------- */

CREATE VIEW monthly_revenue AS
SELECT
    strftime('%Y-%m', clean_date) AS month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM sales_clean
GROUP BY month
ORDER BY month;



/* ---------------------------------------------------
Top Customers View
Used for CRM / customer segmentation
--------------------------------------------------- */

CREATE VIEW top_customers AS
SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice),2) AS total_spent,
    COUNT(DISTINCT InvoiceNo) AS orders
FROM sales_clean
GROUP BY CustomerID
ORDER BY total_spent DESC;



/* ---------------------------------------------------
Top Products View
Used for product performance monitoring
--------------------------------------------------- */

CREATE VIEW top_products AS
SELECT
    Description,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM sales_clean
GROUP BY Description
ORDER BY revenue DESC;
