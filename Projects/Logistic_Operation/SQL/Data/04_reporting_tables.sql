-- ============================================
-- File: 04_reporting_tables.sql
-- Description:
-- Creates reporting tables used for logistics KPI
-- tracking, exception reporting, inventory alerts,
-- carrier scorecards, and monthly summaries
-- ============================================

SET search_path TO logistics;

-- ============================================
-- 1. DAILY KPI SUMMARY TABLE
-- Business use:
-- Stores daily operational KPIs for reporting
-- ============================================
CREATE TABLE IF NOT EXISTS daily_kpi_summary (
    report_date                  DATE PRIMARY KEY,
    total_orders                 INT NOT NULL,
    delivered_orders             INT NOT NULL,
    on_time_deliveries           INT NOT NULL,
    late_deliveries              INT NOT NULL,
    failed_shipments             INT NOT NULL,
    cancelled_shipments          INT NOT NULL,
    total_returns                INT NOT NULL,
    low_stock_alerts             INT NOT NULL,
    total_revenue                NUMERIC(14,2) NOT NULL,
    total_shipping_cost          NUMERIC(14,2) NOT NULL,
    on_time_delivery_rate_pct    NUMERIC(6,2) NOT NULL,
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. DELIVERY EXCEPTION REPORT TABLE
-- Business use:
-- Stores order-level delivery exceptions
-- ============================================
CREATE TABLE IF NOT EXISTS delivery_exception_report (
    exception_id                 SERIAL PRIMARY KEY,
    order_id                     INT NOT NULL,
    customer_name                VARCHAR(100) NOT NULL,
    shipping_region              VARCHAR(50),
    carrier_name                 VARCHAR(100),
    promised_delivery_date       DATE,
    delivery_date                DATE,
    shipment_status              VARCHAR(30),
    delivery_performance         VARCHAR(30),
    days_late                    INT,
    exception_type               VARCHAR(50) NOT NULL,
    severity                     VARCHAR(20) NOT NULL,
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 3. INVENTORY ALERT REPORT TABLE
-- Business use:
-- Stores product-level low stock alerts
-- ============================================
CREATE TABLE IF NOT EXISTS inventory_alert_report (
    alert_id                     SERIAL PRIMARY KEY,
    warehouse_id                 INT NOT NULL,
    warehouse_name               VARCHAR(100) NOT NULL,
    product_id                   INT NOT NULL,
    product_name                 VARCHAR(120) NOT NULL,
    sku                          VARCHAR(50) NOT NULL,
    stock_quantity               INT NOT NULL,
    reorder_level                INT NOT NULL,
    shortage_units               INT NOT NULL,
    alert_severity               VARCHAR(20) NOT NULL,
    last_updated                 TIMESTAMP,
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 4. CARRIER PERFORMANCE SUMMARY TABLE
-- Business use:
-- Stores carrier scorecard metrics for reporting
-- ============================================
CREATE TABLE IF NOT EXISTS carrier_performance_summary (
    carrier_id                   INT PRIMARY KEY,
    carrier_name                 VARCHAR(100) NOT NULL,
    carrier_type                 VARCHAR(30),
    service_level                VARCHAR(30),
    total_shipments              INT NOT NULL,
    delivered_shipments          INT NOT NULL,
    failed_shipments             INT NOT NULL,
    cancelled_shipments          INT NOT NULL,
    avg_shipping_cost            NUMERIC(10,2),
    avg_delivery_days            NUMERIC(10,2),
    on_time_delivery_rate_pct    NUMERIC(6,2),
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 5. MONTHLY REVENUE SUMMARY TABLE
-- Business use:
-- Stores monthly order and revenue trends
-- ============================================
CREATE TABLE IF NOT EXISTS monthly_revenue_summary (
    order_month                  DATE PRIMARY KEY,
    total_orders                 INT NOT NULL,
    active_customers             INT NOT NULL,
    total_revenue                NUMERIC(14,2) NOT NULL,
    avg_order_line_value         NUMERIC(10,2),
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- OPTIONAL: CLEAR EXISTING DATA BEFORE RELOAD
-- These deletes simulate a full refresh pattern
-- ============================================

DELETE FROM daily_kpi_summary;
DELETE FROM delivery_exception_report;
DELETE FROM inventory_alert_report;
DELETE FROM carrier_performance_summary;
DELETE FROM monthly_revenue_summary;

-- ============================================
-- POPULATE DAILY KPI SUMMARY
-- ============================================
INSERT INTO daily_kpi_summary (
    report_date,
    total_orders,
    delivered_orders,
    on_time_deliveries,
    late_deliveries,
    failed_shipments,
    cancelled_shipments,
    total_returns,
    low_stock_alerts,
    total_revenue,
    total_shipping_cost,
    on_time_delivery_rate_pct
)
SELECT
    CURRENT_DATE AS report_date,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM shipments WHERE shipment_status = 'Delivered') AS delivered_orders,
    (
        SELECT COUNT(*)
        FROM vw_order_delivery_performance
        WHERE delivery_performance = 'On Time'
    ) AS on_time_deliveries,
    (
        SELECT COUNT(*)
        FROM vw_order_delivery_performance
        WHERE delivery_performance = 'Late'
    ) AS late_deliveries,
    (SELECT COUNT(*) FROM shipments WHERE shipment_status = 'Failed') AS failed_shipments,
    (SELECT COUNT(*) FROM shipments WHERE shipment_status = 'Cancelled') AS cancelled_shipments,
    (SELECT COUNT(*) FROM returns) AS total_returns,
    (SELECT COUNT(*) FROM vw_inventory_alerts) AS low_stock_alerts,
    (
        SELECT COALESCE(SUM(line_total), 0)
        FROM order_items
    ) AS total_revenue,
    (
        SELECT COALESCE(SUM(shipping_cost), 0)
        FROM shipments
    ) AS total_shipping_cost,
    (
        SELECT COALESCE(
            ROUND(
                100.0 * SUM(
                    CASE
                        WHEN delivery_performance = 'On Time' THEN 1
                        ELSE 0
                    END
                ) / NULLIF(COUNT(*), 0),
                2
            ),
            0
        )
        FROM vw_order_delivery_performance
        WHERE shipment_status = 'Delivered'
    ) AS on_time_delivery_rate_pct;

-- ============================================
-- POPULATE DELIVERY EXCEPTION REPORT
-- ============================================
INSERT INTO delivery_exception_report (
    order_id,
    customer_name,
    shipping_region,
    carrier_name,
    promised_delivery_date,
    delivery_date,
    shipment_status,
    delivery_performance,
    days_late,
    exception_type,
    severity
)
SELECT
    order_id,
    customer_name,
    shipping_region,
    carrier_name,
    promised_delivery_date,
    delivery_date,
    shipment_status,
    delivery_performance,
    days_late,
    CASE
        WHEN delivery_performance = 'Late' THEN 'Late Delivery'
        WHEN shipment_status = 'Failed' THEN 'Failed Shipment'
        WHEN shipment_status = 'Cancelled' THEN 'Cancelled Shipment'
        ELSE 'Other'
    END AS exception_type,
    CASE
        WHEN shipment_status = 'Failed' THEN 'Critical'
        WHEN delivery_performance = 'Late' THEN 'High'
        WHEN shipment_status = 'Cancelled' THEN 'Medium'
        ELSE 'Low'
    END AS severity
FROM vw_order_delivery_performance
WHERE delivery_performance IN ('Late', 'Failed', 'Cancelled');

-- ============================================
-- POPULATE INVENTORY ALERT REPORT
-- ============================================
INSERT INTO inventory_alert_report (
    warehouse_id,
    warehouse_name,
    product_id,
    product_name,
    sku,
    stock_quantity,
    reorder_level,
    shortage_units,
    alert_severity,
    last_updated
)
SELECT
    warehouse_id,
    warehouse_name,
    product_id,
    product_name,
    sku,
    stock_quantity,
    reorder_level,
    shortage_units,
    alert_severity,
    last_updated
FROM vw_inventory_alerts;

-- ============================================
-- POPULATE CARRIER PERFORMANCE SUMMARY
-- ============================================
INSERT INTO carrier_performance_summary (
    carrier_id,
    carrier_name,
    carrier_type,
    service_level,
    total_shipments,
    delivered_shipments,
    failed_shipments,
    cancelled_shipments,
    avg_shipping_cost,
    avg_delivery_days,
    on_time_delivery_rate_pct
)
SELECT
    carrier_id,
    carrier_name,
    carrier_type,
    service_level,
    total_shipments,
    delivered_shipments,
    failed_shipments,
    cancelled_shipments,
    avg_shipping_cost,
    avg_delivery_days,
    on_time_delivery_rate_pct
FROM vw_carrier_performance;

-- ============================================
-- POPULATE MONTHLY REVENUE SUMMARY
-- ============================================
INSERT INTO monthly_revenue_summary (
    order_month,
    total_orders,
    active_customers,
    total_revenue,
    avg_order_line_value
)
SELECT
    order_month::DATE,
    total_orders,
    active_customers,
    total_revenue,
    avg_order_line_value
FROM vw_monthly_order_revenue;
