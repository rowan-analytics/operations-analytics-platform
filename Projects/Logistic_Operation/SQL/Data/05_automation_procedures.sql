-- ============================================
-- File: 05_automation_procedures.sql
-- Description:
-- Stored procedures to automate refresh of
-- logistics reporting tables for KPI reporting,
-- exception monitoring, inventory alerts,
-- carrier scorecards, and monthly summaries
-- ============================================

SET search_path TO logistics;

-- ============================================
-- 1. REFRESH DAILY KPI SUMMARY
-- Business use:
-- Rebuild daily KPI snapshot for dashboard reporting
-- ============================================
CREATE OR REPLACE PROCEDURE sp_refresh_daily_kpi_summary()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM daily_kpi_summary
    WHERE report_date = CURRENT_DATE;

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
END;
$$;

-- ============================================
-- 2. REFRESH DELIVERY EXCEPTION REPORT
-- Business use:
-- Rebuild order-level exception table
-- ============================================
CREATE OR REPLACE PROCEDURE sp_refresh_delivery_exception_report()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE delivery_exception_report RESTART IDENTITY;

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
END;
$$;

-- ============================================
-- 3. REFRESH INVENTORY ALERT REPORT
-- Business use:
-- Rebuild low-stock alert table
-- ============================================
CREATE OR REPLACE PROCEDURE sp_refresh_inventory_alert_report()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE inventory_alert_report RESTART IDENTITY;

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
END;
$$;

-- ============================================
-- 4. REFRESH CARRIER PERFORMANCE SUMMARY
-- Business use:
-- Rebuild carrier scorecard metrics
-- ============================================
CREATE OR REPLACE PROCEDURE sp_refresh_carrier_performance_summary()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE carrier_performance_summary;

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
END;
$$;

-- ============================================
-- 5. REFRESH MONTHLY REVENUE SUMMARY
-- Business use:
-- Rebuild monthly trend table for dashboard reporting
-- ============================================
CREATE OR REPLACE PROCEDURE sp_refresh_monthly_revenue_summary()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE monthly_revenue_summary;

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
END;
$$;

-- ============================================
-- 6. MASTER REFRESH PROCEDURE
-- Business use:
-- Refresh all reporting outputs in one run
-- ============================================
CREATE OR REPLACE PROCEDURE sp_refresh_all_logistics_reports()
LANGUAGE plpgsql
AS $$
BEGIN
    CALL sp_refresh_daily_kpi_summary();
    CALL sp_refresh_delivery_exception_report();
    CALL sp_refresh_inventory_alert_report();
    CALL sp_refresh_carrier_performance_summary();
    CALL sp_refresh_monthly_revenue_summary();
END;
$$;

-- ============================================
-- 7. EXAMPLE EXECUTION
-- Business use:
-- Manual trigger for scheduled refresh simulation
-- ============================================

-- Run all reporting refresh procedures
CALL sp_refresh_all_logistics_reports();

-- Optional: run procedures individually
-- CALL sp_refresh_daily_kpi_summary();
-- CALL sp_refresh_delivery_exception_report();
-- CALL sp_refresh_inventory_alert_report();
-- CALL sp_refresh_carrier_performance_summary();
-- CALL sp_refresh_monthly_revenue_summary();
