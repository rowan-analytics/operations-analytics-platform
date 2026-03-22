-- ============================================
-- File: 08_validation_checks.sql
-- Description:
-- Validation and reconciliation checks for the
-- logistics reporting pipeline. Used to confirm
-- that source data, views, and reporting tables
-- are consistent after refresh procedures run.
-- ============================================

SET search_path TO logistics;

-- ============================================
-- 1. SOURCE TABLE ROW COUNTS
-- Business use:
-- Quick validation of base table population
-- ============================================
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'warehouses', COUNT(*) FROM warehouses
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL
SELECT 'carriers', COUNT(*) FROM carriers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'operations_alerts', COUNT(*) FROM operations_alerts
ORDER BY table_name;

-- ============================================
-- 2. REPORTING TABLE ROW COUNTS
-- Business use:
-- Confirm reporting outputs were refreshed
-- ============================================
SELECT 'daily_kpi_summary' AS table_name, COUNT(*) AS row_count FROM daily_kpi_summary
UNION ALL
SELECT 'delivery_exception_report', COUNT(*) FROM delivery_exception_report
UNION ALL
SELECT 'inventory_alert_report', COUNT(*) FROM inventory_alert_report
UNION ALL
SELECT 'carrier_performance_summary', COUNT(*) FROM carrier_performance_summary
UNION ALL
SELECT 'monthly_revenue_summary', COUNT(*) FROM monthly_revenue_summary
ORDER BY table_name;

-- ============================================
-- 3. CHECK FOR ORDERS WITHOUT ORDER ITEMS
-- Business use:
-- Prevent incomplete revenue reporting
-- ============================================
SELECT
    o.order_id,
    o.order_status
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- ============================================
-- 4. CHECK FOR ORDERS WITHOUT SHIPMENTS
-- Business use:
-- Validate delivery reporting completeness
-- ============================================
SELECT
    o.order_id,
    o.order_status
FROM orders o
LEFT JOIN shipments s
    ON o.order_id = s.order_id
WHERE s.order_id IS NULL;

-- ============================================
-- 5. RECONCILE TOTAL REVENUE
-- Business use:
-- Confirm monthly and daily reporting tables
-- align with source transaction data
-- ============================================

-- Source revenue
SELECT
    'source_order_items' AS revenue_source,
    COALESCE(SUM(line_total), 0) AS total_revenue
FROM order_items;

-- Daily KPI revenue
SELECT
    'daily_kpi_summary' AS revenue_source,
    COALESCE(SUM(total_revenue), 0) AS total_revenue
FROM daily_kpi_summary;

-- Monthly revenue summary
SELECT
    'monthly_revenue_summary' AS revenue_source,
    COALESCE(SUM(total_revenue), 0) AS total_revenue
FROM monthly_revenue_summary;

-- ============================================
-- 6. RECONCILE SHIPPING COST
-- Business use:
-- Confirm shipping cost in KPI output matches source
-- ============================================
SELECT
    'source_shipments' AS shipping_cost_source,
    COALESCE(SUM(shipping_cost), 0) AS total_shipping_cost
FROM shipments;

SELECT
    'daily_kpi_summary' AS shipping_cost_source,
    COALESCE(SUM(total_shipping_cost), 0) AS total_shipping_cost
FROM daily_kpi_summary;

-- ============================================
-- 7. VALIDATE DELIVERY EXCEPTIONS
-- Business use:
-- Confirm exception report matches source logic
-- ============================================

-- Source count of late / failed / cancelled orders
SELECT
    COUNT(*) AS expected_exception_count
FROM vw_order_delivery_performance
WHERE delivery_performance IN ('Late', 'Failed', 'Cancelled');

-- Report table count
SELECT
    COUNT(*) AS actual_exception_count
FROM delivery_exception_report;

-- Detailed mismatch check
SELECT
    v.order_id,
    v.delivery_performance,
    r.order_id AS report_order_id,
    r.exception_type
FROM vw_order_delivery_performance v
LEFT JOIN delivery_exception_report r
    ON v.order_id = r.order_id
WHERE v.delivery_performance IN ('Late', 'Failed', 'Cancelled');

-- ============================================
-- 8. VALIDATE INVENTORY ALERTS
-- Business use:
-- Confirm low-stock reporting is consistent
-- ============================================

-- Source count of low-stock records
SELECT
    COUNT(*) AS expected_inventory_alerts
FROM vw_inventory_alerts;

-- Alert report count
SELECT
    COUNT(*) AS actual_inventory_alerts
FROM inventory_alert_report;

-- Detailed comparison
SELECT
    v.product_id,
    v.warehouse_id,
    v.shortage_units,
    a.product_id AS report_product_id,
    a.warehouse_id AS report_warehouse_id,
    a.shortage_units AS report_shortage_units
FROM vw_inventory_alerts v
LEFT JOIN inventory_alert_report a
    ON v.product_id = a.product_id
   AND v.warehouse_id = a.warehouse_id;

-- ============================================
-- 9. VALIDATE CARRIER PERFORMANCE SUMMARY
-- Business use:
-- Confirm carrier reporting table matches view logic
-- ============================================

-- Source carrier count
SELECT
    COUNT(*) AS expected_carrier_rows
FROM vw_carrier_performance;

-- Reporting table carrier count
SELECT
    COUNT(*) AS actual_carrier_rows
FROM carrier_performance_summary;

-- Detailed comparison
SELECT
    v.carrier_id,
    v.carrier_name,
    v.total_shipments AS expected_total_shipments,
    c.total_shipments AS actual_total_shipments,
    v.on_time_delivery_rate_pct AS expected_on_time_rate,
    c.on_time_delivery_rate_pct AS actual_on_time_rate
FROM vw_carrier_performance v
LEFT JOIN carrier_performance_summary c
    ON v.carrier_id = c.carrier_id;

-- ============================================
-- 10. VALIDATE MONTHLY REVENUE SUMMARY
-- Business use:
-- Confirm monthly summary matches view logic
-- ============================================
SELECT
    v.order_month,
    v.total_orders AS expected_total_orders,
    m.total_orders AS actual_total_orders,
    v.total_revenue AS expected_total_revenue,
    m.total_revenue AS actual_total_revenue
FROM vw_monthly_order_revenue v
LEFT JOIN monthly_revenue_summary m
    ON v.order_month::DATE = m.order_month;

-- ============================================
-- 11. CHECK DAILY KPI SUMMARY QUALITY
-- Business use:
-- Confirm KPI snapshot is populated correctly
-- ============================================
SELECT *
FROM daily_kpi_summary
WHERE total_orders < 0
   OR delivered_orders < 0
   OR on_time_deliveries < 0
   OR late_deliveries < 0
   OR failed_shipments < 0
   OR cancelled_shipments < 0
   OR total_returns < 0
   OR low_stock_alerts < 0
   OR total_revenue < 0
   OR total_shipping_cost < 0
   OR on_time_delivery_rate_pct < 0
   OR on_time_delivery_rate_pct > 100;

-- ============================================
-- 12. CHECK FOR DUPLICATES IN REPORTING TABLES
-- Business use:
-- Prevent duplicate records after refresh runs
-- ============================================

-- Delivery exception duplicates
SELECT
    order_id,
    exception_type,
    COUNT(*) AS duplicate_count
FROM delivery_exception_report
GROUP BY order_id, exception_type
HAVING COUNT(*) > 1;

-- Inventory alert duplicates
SELECT
    warehouse_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM inventory_alert_report
GROUP BY warehouse_id, product_id
HAVING COUNT(*) > 1;

-- Monthly revenue summary duplicates
SELECT
    order_month,
    COUNT(*) AS duplicate_count
FROM monthly_revenue_summary
GROUP BY order_month
HAVING COUNT(*) > 1;

-- ============================================
-- 13. FINAL PASS / FAIL STYLE SUMMARY
-- Business use:
-- Quick QA view for manual review
-- ============================================
SELECT
    'Orders with no order items' AS check_name,
    COUNT(*) AS issue_count
FROM (
    SELECT o.order_id
    FROM orders o
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE oi.order_id IS NULL
) t

UNION ALL

SELECT
    'Orders with no shipments' AS check_name,
    COUNT(*) AS issue_count
FROM (
    SELECT o.order_id
    FROM orders o
    LEFT JOIN shipments s
        ON o.order_id = s.order_id
    WHERE s.order_id IS NULL
) t

UNION ALL

SELECT
    'Duplicate delivery exceptions' AS check_name,
    COUNT(*) AS issue_count
FROM (
    SELECT order_id, exception_type
    FROM delivery_exception_report
    GROUP BY order_id, exception_type
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'Duplicate inventory alerts' AS check_name,
    COUNT(*) AS issue_count
FROM (
    SELECT warehouse_id, product_id
    FROM inventory_alert_report
    GROUP BY warehouse_id, product_id
    HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
    'Invalid KPI summary values' AS check_name,
    COUNT(*) AS issue_count
FROM (
    SELECT *
    FROM daily_kpi_summary
    WHERE total_orders < 0
       OR delivered_orders < 0
       OR on_time_deliveries < 0
       OR late_deliveries < 0
       OR failed_shipments < 0
       OR cancelled_shipments < 0
       OR total_returns < 0
       OR low_stock_alerts < 0
       OR total_revenue < 0
       OR total_shipping_cost < 0
       OR on_time_delivery_rate_pct < 0
       OR on_time_delivery_rate_pct > 100
) t;
