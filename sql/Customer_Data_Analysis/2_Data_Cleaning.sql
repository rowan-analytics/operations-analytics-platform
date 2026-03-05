/*
Step: Data Cleaning
Goal: Identify invalid rows and returns
*/

-- negative quantities (returns)
SELECT *
FROM Online_retails_data
WHERE Quantity < 0;

-- invalid prices
SELECT *
FROM Online_retails_data
WHERE UnitPrice <= 0;

-- missing customer ids
SELECT *
FROM Online_retails_data
WHERE CustomerID IS NULL;
