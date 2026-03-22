-- ============================================
-- File: 04_core_queries.sql
-- Description:
-- Core business queries for logistics reporting
-- Covers order trends, delivery performance,
-- inventory risk, carrier analysis, and returns
-- ============================================

SET search_path TO logistics;

-- ============================================
-- 1. MONTHLY ORDER VOLUME AND REVENUE
-- Business use:
-- Track order demand and revenue trend over time
-- ============================================
SELECT
    DATE_TRUNC('month', o.order_date) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.line_total) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY order_month;

-- ============================================
-- 2. ORDER-LEVEL DELIVERY STATUS
-- Business use:
-- Classify orders as On Time, Late, Pending, Failed, Cancelled
-- ============================================
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.promised_delivery_date,
    s.dispatch_date,
    s.delivery_date,
    s.shipment_status,
    CASE
        WHEN s.shipment_status = 'Cancelled' THEN 'Cancelled'
        WHEN s.shipment_status = 'Failed' THEN 'Failed'
        WHEN s.delivery_date IS NULL THEN 'Pending'
        WHEN s.delivery_date > o.promised_delivery_date THEN 'Late'
        ELSE 'On Time'
    END AS delivery_performance
FROM orders o
LEFT JOIN shipments s
    ON o.order_id = s.order_id
ORDER BY o.order_id;

-- ============================================
-- 3. ON-TIME DELIVERY RATE
-- Business use:
-- KPI for service level performance
-- ============================================
SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.delivery_date <= o.promised_delivery_date THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_delivery_rate_pct
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
WHERE s.shipment_status = 'Delivered';

-- ============================================
-- 4. LATE DELIVERIES
-- Business use:
-- Exception reporting for delayed shipments
-- ============================================
SELECT
    o.order_id,
    c.customer_name,
    o.shipping_region,
    o.promised_delivery_date,
    s.delivery_date,
    (s.delivery_date - o.promised_delivery_date) AS days_late,
    cr.carrier_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN shipments s
    ON o.order_id = s.order_id
JOIN carriers cr
    ON s.carrier_id = cr.carrier_id
WHERE s.shipment_status = 'Delivered'
  AND s.delivery_date > o.promised_delivery_date
ORDER BY days_late DESC;

-- ============================================
-- 5. AVERAGE DELIVERY TIME BY CARRIER
-- Business use:
-- Compare carrier speed and efficiency
-- ============================================
SELECT
    cr.carrier_name,
    COUNT(*) AS total_delivered_shipments,
    ROUND(AVG(s.delivery_date - s.dispatch_date), 2) AS avg_delivery_days
FROM shipments s
JOIN carriers cr
    ON s.carrier_id = cr.carrier_id
WHERE s.shipment_status = 'Delivered'
  AND s.dispatch_date IS NOT NULL
  AND s.delivery_date IS NOT NULL
GROUP BY cr.carrier_name
ORDER BY avg_delivery_days;

-- ============================================
-- 6. SHIPPING COST ANALYSIS BY CARRIER
-- Business use:
-- Monitor total and average shipping cost by provider
-- ============================================
SELECT
    cr.carrier_name,
    COUNT(*) AS total_shipments,
    SUM(s.shipping_cost) AS total_shipping_cost,
    ROUND(AVG(s.shipping_cost), 2) AS avg_shipping_cost
FROM shipments s
JOIN carriers cr
    ON s.carrier_id = cr.carrier_id
GROUP BY cr.carrier_name
ORDER BY total_shipping_cost DESC;

-- ============================================
-- 7. FAILED AND CANCELLED SHIPMENTS
-- Business use:
-- Identify operational failures and service issues
-- ============================================
SELECT
    o.order_id,
    c.customer_name,
    o.shipping_region,
    s.shipment_status,
    s.dispatch_date,
    s.delivery_date,
    cr.carrier_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN shipments s
    ON o.order_id = s.order_id
JOIN carriers cr
    ON s.carrier_id = cr.carrier_id
WHERE s.shipment_status IN ('Failed', 'Cancelled')
ORDER BY o.order_id;

-- ============================================
-- 8. LOW STOCK ALERT REPORT
-- Business use:
-- Identify products below reorder threshold
-- ============================================
SELECT
    w.warehouse_name,
    p.product_name,
    p.sku,
    i.stock_quantity,
    i.reorder_level,
    (i.reorder_level - i.stock_quantity) AS shortage_units
FROM inventory i
JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level
ORDER BY shortage_units DESC;

-- ============================================
-- 9. WAREHOUSE INVENTORY HEALTH SUMMARY
-- Business use:
-- Compare warehouses by number of low-stock products
-- ============================================
SELECT
    w.warehouse_name,
    COUNT(*) AS total_skus,
    SUM(
        CASE
            WHEN i.stock_quantity < i.reorder_level THEN 1
            ELSE 0
        END
    ) AS low_stock_skus
FROM warehouses w
JOIN inventory i
    ON w.warehouse_id = i.warehouse_id
GROUP BY w.warehouse_name
ORDER BY low_stock_skus DESC;

-- ============================================
-- 10. TOP CUSTOMERS BY REVENUE
-- Business use:
-- Identify highest-value customers
-- ============================================
SELECT
    c.customer_name,
    c.customer_type,
    SUM(oi.line_total) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name, c.customer_type
ORDER BY total_revenue DESC;

-- ============================================
-- 11. RETURNS SUMMARY
-- Business use:
-- Monitor return volume and refund value
-- ============================================
SELECT
    COUNT(*) AS total_returns,
    SUM(refund_amount) AS total_refund_amount,
    ROUND(AVG(refund_amount), 2) AS avg_refund_amount
FROM returns;

-- ============================================
-- 12. RETURNS BY REASON
-- Business use:
-- Identify main causes of returned orders
-- ============================================
SELECT
    return_reason,
    COUNT(*) AS return_count,
    SUM(refund_amount) AS total_refund_amount
FROM returns
GROUP BY return_reason
ORDER BY return_count DESC, total_refund_amount DESC;

-- ============================================
-- 13. PRODUCT-LEVEL RETURN ANALYSIS
-- Business use:
-- Identify products most associated with returns
-- ============================================
SELECT
    p.product_name,
    COUNT(DISTINCT r.return_id) AS total_returns
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_returns DESC, p.product_name;

-- ============================================
-- 14. REGIONAL DELIVERY PERFORMANCE
-- Business use:
-- Compare service quality across regions
-- ============================================
SELECT
    o.shipping_region,
    COUNT(*) AS total_delivered_orders,
    SUM(
        CASE
            WHEN s.delivery_date <= o.promised_delivery_date THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.delivery_date <= o.promised_delivery_date THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_rate_pct
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
WHERE s.shipment_status = 'Delivered'
GROUP BY o.shipping_region
ORDER BY on_time_rate_pct DESC;

-- ============================================
-- 15. OPEN OPERATIONAL EXCEPTIONS
-- Business use:
-- Combine key exceptions for operational review
-- ============================================
SELECT
    o.order_id,
    'Late Delivery' AS exception_type,
    o.shipping_region AS reference_area,
    c.customer_name AS reference_name
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE s.shipment_status = 'Delivered'
  AND s.delivery_date > o.promised_delivery_date

UNION ALL

SELECT
    o.order_id,
    'Failed Shipment' AS exception_type,
    o.shipping_region AS reference_area,
    c.customer_name AS reference_name
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE s.shipment_status = 'Failed'

UNION ALL

SELECT
    p.product_id AS order_id,
    'Low Stock' AS exception_type,
    w.warehouse_name AS reference_area,
    p.product_name AS reference_name
FROM inventory i
JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level
ORDER BY exception_type, reference_area;
