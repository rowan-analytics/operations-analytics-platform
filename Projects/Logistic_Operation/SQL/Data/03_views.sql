-- ============================================
-- File: 03_views.sql
-- Description:
-- Reusable reporting views for logistics operations
-- Supports KPI reporting, exception monitoring,
-- inventory alerts, carrier analysis, and returns
-- ============================================

SET search_path TO logistics;

-- ============================================
-- 1. ORDER DELIVERY PERFORMANCE VIEW
-- Business use:
-- Central view for order-level delivery reporting
-- ============================================
CREATE OR REPLACE VIEW vw_order_delivery_performance AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_name,
    c.customer_type,
    o.order_date,
    o.promised_delivery_date,
    o.order_status,
    o.shipping_region,
    o.shipping_city,
    o.priority_level,
    s.shipment_id,
    s.dispatch_date,
    s.delivery_date,
    s.shipment_status,
    s.shipping_cost,
    cr.carrier_name,
    CASE
        WHEN s.shipment_status = 'Cancelled' THEN 'Cancelled'
        WHEN s.shipment_status = 'Failed' THEN 'Failed'
        WHEN s.delivery_date IS NULL THEN 'Pending'
        WHEN s.delivery_date > o.promised_delivery_date THEN 'Late'
        ELSE 'On Time'
    END AS delivery_performance,
    CASE
        WHEN s.delivery_date IS NOT NULL
         AND s.dispatch_date IS NOT NULL
        THEN (s.delivery_date - s.dispatch_date)
        ELSE NULL
    END AS delivery_days,
    CASE
        WHEN s.delivery_date IS NOT NULL
         AND s.delivery_date > o.promised_delivery_date
        THEN (s.delivery_date - o.promised_delivery_date)
        ELSE 0
    END AS days_late
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN shipments s
    ON o.order_id = s.order_id
LEFT JOIN carriers cr
    ON s.carrier_id = cr.carrier_id;

-- ============================================
-- 2. INVENTORY ALERTS VIEW
-- Business use:
-- Reusable low-stock monitoring view
-- ============================================
CREATE OR REPLACE VIEW vw_inventory_alerts AS
SELECT
    i.inventory_id,
    i.warehouse_id,
    w.warehouse_name,
    w.region AS warehouse_region,
    i.product_id,
    p.product_name,
    p.category,
    p.sku,
    i.stock_quantity,
    i.reorder_level,
    (i.reorder_level - i.stock_quantity) AS shortage_units,
    CASE
        WHEN i.stock_quantity = 0 THEN 'Critical'
        WHEN i.stock_quantity < i.reorder_level THEN 'High'
        ELSE 'Normal'
    END AS alert_severity,
    i.last_updated
FROM inventory i
JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level;

-- ============================================
-- 3. CARRIER PERFORMANCE VIEW
-- Business use:
-- Scorecard-style carrier summary for reporting
-- ============================================
CREATE OR REPLACE VIEW vw_carrier_performance AS
SELECT
    cr.carrier_id,
    cr.carrier_name,
    cr.carrier_type,
    cr.service_level,
    COUNT(s.shipment_id) AS total_shipments,
    SUM(CASE WHEN s.shipment_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_shipments,
    SUM(CASE WHEN s.shipment_status = 'Failed' THEN 1 ELSE 0 END) AS failed_shipments,
    SUM(CASE WHEN s.shipment_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_shipments,
    ROUND(AVG(s.shipping_cost), 2) AS avg_shipping_cost,
    ROUND(
        AVG(
            CASE
                WHEN s.shipment_status = 'Delivered'
                 AND s.dispatch_date IS NOT NULL
                 AND s.delivery_date IS NOT NULL
                THEN (s.delivery_date - s.dispatch_date)
                ELSE NULL
            END
        ),
        2
    ) AS avg_delivery_days,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.shipment_status = 'Delivered'
                 AND s.delivery_date <= o.promised_delivery_date
                THEN 1
                ELSE 0
            END
        ) / NULLIF(SUM(CASE WHEN s.shipment_status = 'Delivered' THEN 1 ELSE 0 END), 0),
        2
    ) AS on_time_delivery_rate_pct
FROM carriers cr
LEFT JOIN shipments s
    ON cr.carrier_id = s.carrier_id
LEFT JOIN orders o
    ON s.order_id = o.order_id
GROUP BY
    cr.carrier_id,
    cr.carrier_name,
    cr.carrier_type,
    cr.service_level;

-- ============================================
-- 4. RETURNS SUMMARY VIEW
-- Business use:
-- Order-level returns analysis with product linkage
-- ============================================
CREATE OR REPLACE VIEW vw_returns_summary AS
SELECT
    r.return_id,
    r.order_id,
    r.return_date,
    r.return_reason,
    r.refund_amount,
    r.return_status,
    o.customer_id,
    c.customer_name,
    o.order_date,
    o.shipping_region,
    p.product_id,
    p.product_name,
    p.category
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;

-- ============================================
-- 5. MONTHLY ORDER AND REVENUE VIEW
-- Business use:
-- Supports monthly trend reporting in Power BI
-- ============================================
CREATE OR REPLACE VIEW vw_monthly_order_revenue AS
SELECT
    DATE_TRUNC('month', o.order_date) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS active_customers,
    SUM(oi.line_total) AS total_revenue,
    ROUND(AVG(oi.line_total), 2) AS avg_order_line_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY order_month;

-- ============================================
-- 6. REGIONAL DELIVERY PERFORMANCE VIEW
-- Business use:
-- Compare on-time service performance by region
-- ============================================
CREATE OR REPLACE VIEW vw_regional_delivery_performance AS
SELECT
    o.shipping_region,
    COUNT(*) AS total_delivered_orders,
    SUM(
        CASE
            WHEN s.delivery_date <= o.promised_delivery_date THEN 1
            ELSE 0
        END
    ) AS on_time_orders,
    SUM(
        CASE
            WHEN s.delivery_date > o.promised_delivery_date THEN 1
            ELSE 0
        END
    ) AS late_orders,
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
-- 7. OPERATIONAL EXCEPTIONS VIEW
-- Business use:
-- Unified exception layer for logistics operations
-- ============================================
CREATE OR REPLACE VIEW vw_operational_exceptions AS
SELECT
    CAST(o.order_id AS VARCHAR) AS reference_id,
    'Late Delivery' AS exception_type,
    o.shipping_region AS reference_area,
    c.customer_name AS reference_name,
    'High' AS severity,
    'Order delivered after promised delivery date' AS exception_message
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE s.shipment_status = 'Delivered'
  AND s.delivery_date > o.promised_delivery_date

UNION ALL

SELECT
    CAST(o.order_id AS VARCHAR) AS reference_id,
    'Failed Shipment' AS exception_type,
    o.shipping_region AS reference_area,
    c.customer_name AS reference_name,
    'Critical' AS severity,
    'Shipment marked as failed' AS exception_message
FROM orders o
JOIN shipments s
    ON o.order_id = s.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE s.shipment_status = 'Failed'

UNION ALL

SELECT
    CAST(p.product_id AS VARCHAR) AS reference_id,
    'Low Stock' AS exception_type,
    w.warehouse_name AS reference_area,
    p.product_name AS reference_name,
    CASE
        WHEN i.stock_quantity = 0 THEN 'Critical'
        ELSE 'High'
    END AS severity,
    'Inventory is below reorder level' AS exception_message
FROM inventory i
JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level;
