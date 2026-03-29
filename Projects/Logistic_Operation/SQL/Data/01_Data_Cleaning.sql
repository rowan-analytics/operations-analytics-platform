-- ============================================
-- File: 03_data_cleaning.sql
-- Description:
-- Performs data quality checks and basic cleaning
-- to prepare logistics data for reporting and automation
-- ============================================

SET search_path TO logistics;

-- ============================================
-- 1. STANDARDISE TEXT FIELDS
-- Example: trim spaces and normalise case where needed
-- ============================================

UPDATE customers
SET customer_name = TRIM(customer_name),
    customer_type = INITCAP(TRIM(customer_type)),
    region = INITCAP(TRIM(region)),
    city = INITCAP(TRIM(city));

UPDATE products
SET product_name = TRIM(product_name),
    category = INITCAP(TRIM(category)),
    sku = UPPER(TRIM(sku));

UPDATE warehouses
SET warehouse_name = TRIM(warehouse_name),
    region = INITCAP(TRIM(region)),
    city = INITCAP(TRIM(city)),
    manager_name = TRIM(manager_name);

UPDATE carriers
SET carrier_name = TRIM(carrier_name),
    carrier_type = INITCAP(TRIM(carrier_type)),
    service_level = INITCAP(TRIM(service_level));

UPDATE orders
SET order_status = INITCAP(TRIM(order_status)),
    shipping_region = INITCAP(TRIM(shipping_region)),
    shipping_city = INITCAP(TRIM(shipping_city)),
    priority_level = INITCAP(TRIM(priority_level));

UPDATE shipments
SET shipment_status = INITCAP(TRIM(shipment_status)),
    tracking_number = UPPER(TRIM(tracking_number));

UPDATE returns
SET return_reason = TRIM(return_reason),
    return_status = INITCAP(TRIM(return_status));

-- ============================================
-- 2. CHECK FOR DUPLICATE BUSINESS KEYS
-- These queries help validate source data before reporting
-- ============================================

-- Duplicate SKUs
SELECT
    sku,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY sku
HAVING COUNT(*) > 1;

-- Duplicate tracking numbers
SELECT
    tracking_number,
    COUNT(*) AS duplicate_count
FROM shipments
GROUP BY tracking_number
HAVING COUNT(*) > 1;

-- Duplicate warehouse-product inventory combinations
SELECT
    warehouse_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM inventory
GROUP BY warehouse_id, product_id
HAVING COUNT(*) > 1;

-- ============================================
-- 3. CHECK FOR NULLS IN CRITICAL REPORTING FIELDS
-- ============================================

-- Orders missing promised delivery date
SELECT *
FROM orders
WHERE promised_delivery_date IS NULL;

-- Delivered shipments missing delivery date
SELECT *
FROM shipments
WHERE shipment_status = 'Delivered'
  AND delivery_date IS NULL;

-- Shipments missing dispatch date but not cancelled
SELECT *
FROM shipments
WHERE shipment_status IN ('Delivered', 'In Transit', 'Failed')
  AND dispatch_date IS NULL;

-- Customers missing region
SELECT *
FROM customers
WHERE region IS NULL;

-- ============================================
-- 4. CHECK FOR INVALID NUMERIC VALUES
-- ============================================

-- Negative or zero stock issues
SELECT *
FROM inventory
WHERE stock_quantity < 0
   OR reorder_level < 0;

-- Invalid product prices
SELECT *
FROM products
WHERE unit_price < 0
   OR weight_kg < 0;

-- Invalid shipping costs
SELECT *
FROM shipments
WHERE shipping_cost < 0;

-- Invalid refund amounts
SELECT *
FROM returns
WHERE refund_amount < 0;

-- ============================================
-- 5. CHECK FOR LOGICAL DATE ISSUES
-- ============================================

-- Delivery before dispatch
SELECT *
FROM shipments
WHERE delivery_date IS NOT NULL
  AND dispatch_date IS NOT NULL
  AND delivery_date < dispatch_date;

-- Promised delivery before order date
SELECT *
FROM orders
WHERE promised_delivery_date < order_date;

-- Return date before order date
SELECT
    r.return_id,
    r.order_id,
    o.order_date,
    r.return_date
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
WHERE r.return_date < o.order_date;

-- ============================================
-- 6. CHECK STATUS CONSISTENCY
-- These are useful for identifying mismatches before KPI reporting
-- ============================================

-- Orders marked delivered but linked shipment not delivered
SELECT
    o.order_id,
    o.order_status,
    s.shipment_status
FROM orders o
LEFT JOIN shipments s
    ON o.order_id = s.order_id
WHERE o.order_status = 'Delivered'
  AND (s.shipment_status IS NULL OR s.shipment_status <> 'Delivered');

-- Cancelled orders that still have delivery dates
SELECT
    o.order_id,
    o.order_status,
    s.shipment_status,
    s.delivery_date
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
WHERE o.order_status = 'Cancelled'
  AND s.delivery_date IS NOT NULL;

-- In-transit shipments with delivery dates already populated
SELECT *
FROM shipments
WHERE shipment_status = 'In Transit'
  AND delivery_date IS NOT NULL;

-- Failed shipments with a delivery date
SELECT *
FROM shipments
WHERE shipment_status = 'Failed'
  AND delivery_date IS NOT NULL;

-- ============================================
-- 7. OPTIONAL CLEAN-UP FIXES
-- These are examples of practical correction logic
-- ============================================

-- Ensure cancelled shipments have zero shipping cost if dispatch never happened
UPDATE shipments
SET shipping_cost = 0
WHERE shipment_status = 'Cancelled'
  AND dispatch_date IS NULL;

-- Standardise blank cities to NULL
UPDATE customers
SET city = NULL
WHERE city = '';

UPDATE orders
SET shipping_city = NULL
WHERE shipping_city = '';

UPDATE warehouses
SET city = NULL
WHERE city = '';

-- ============================================
-- 8. REPORTING READINESS CHECKS
-- Useful final checks before building views/tables
-- ============================================

-- Orders without shipment records
SELECT
    o.order_id,
    o.order_status
FROM orders o
LEFT JOIN shipments s
    ON o.order_id = s.order_id
WHERE s.order_id IS NULL;

-- Orders without order items
SELECT
    o.order_id
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- Returns linked to non-delivered or cancelled orders
SELECT
    r.return_id,
    r.order_id,
    o.order_status
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
WHERE o.order_status IN ('Cancelled', 'Pending');

-- ============================================
-- END OF FILE
-- ============================================
