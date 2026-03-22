-- ============================================
-- File: 02_sample_data.sql
-- Description:
-- Inserts realistic sample data for logistics operations
-- Includes late deliveries, failed shipments, low stock, returns
-- ============================================

SET search_path TO logistics;

-- ============================================
-- CUSTOMERS
-- ============================================
INSERT INTO customers VALUES
(1, 'Alpha Retail', 'Retail', 'Singapore', 'Singapore', CURRENT_TIMESTAMP),
(2, 'Beta Wholesale', 'Wholesale', 'Malaysia', 'Johor Bahru', CURRENT_TIMESTAMP),
(3, 'Gamma Corp', 'Corporate', 'Singapore', 'Singapore', CURRENT_TIMESTAMP),
(4, 'Delta Stores', 'Retail', 'Indonesia', 'Batam', CURRENT_TIMESTAMP),
(5, 'Epsilon Ltd', 'Corporate', 'Singapore', 'Singapore', CURRENT_TIMESTAMP);

-- ============================================
-- PRODUCTS
-- ============================================
INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 'SKU001', 1200.00, 2.5, TRUE, CURRENT_TIMESTAMP),
(2, 'Phone', 'Electronics', 'SKU002', 800.00, 0.5, TRUE, CURRENT_TIMESTAMP),
(3, 'Headphones', 'Accessories', 'SKU003', 150.00, 0.3, TRUE, CURRENT_TIMESTAMP),
(4, 'Monitor', 'Electronics', 'SKU004', 300.00, 4.0, TRUE, CURRENT_TIMESTAMP),
(5, 'Keyboard', 'Accessories', 'SKU005', 80.00, 0.8, TRUE, CURRENT_TIMESTAMP);

-- ============================================
-- WAREHOUSES
-- ============================================
INSERT INTO warehouses VALUES
(1, 'SG Central Warehouse', 'Singapore', 'Singapore', 10000, 'John Tan', CURRENT_TIMESTAMP),
(2, 'JB Warehouse', 'Malaysia', 'Johor Bahru', 8000, 'Ali Rahman', CURRENT_TIMESTAMP);

-- ============================================
-- CARRIERS
-- ============================================
INSERT INTO carriers VALUES
(1, 'DHL', 'Air', 'Express', TRUE, CURRENT_TIMESTAMP),
(2, 'Grab Logistics', 'Road', 'Same Day', TRUE, CURRENT_TIMESTAMP),
(3, 'NinjaVan', 'Road', 'Standard', TRUE, CURRENT_TIMESTAMP);

-- ============================================
-- INVENTORY (include low stock cases)
-- ============================================
INSERT INTO inventory VALUES
(1, 1, 1, 50, 20, CURRENT_TIMESTAMP),
(2, 1, 2, 10, 30, CURRENT_TIMESTAMP), -- LOW STOCK
(3, 1, 3, 100, 50, CURRENT_TIMESTAMP),
(4, 2, 4, 5, 20, CURRENT_TIMESTAMP),  -- LOW STOCK
(5, 2, 5, 60, 30, CURRENT_TIMESTAMP);

-- ============================================
-- ORDERS
-- ============================================
INSERT INTO orders VALUES
(1, 1, '2024-01-01', '2024-01-05', 'Delivered', 'Singapore', 'Singapore', 'Standard', CURRENT_TIMESTAMP),
(2, 2, '2024-01-02', '2024-01-06', 'Delivered', 'Malaysia', 'Johor Bahru', 'Express', CURRENT_TIMESTAMP),
(3, 3, '2024-01-03', '2024-01-07', 'Delivered', 'Singapore', 'Singapore', 'Standard', CURRENT_TIMESTAMP),
(4, 4, '2024-01-04', '2024-01-08', 'Cancelled', 'Indonesia', 'Batam', 'Standard', CURRENT_TIMESTAMP),
(5, 5, '2024-01-05', '2024-01-09', 'Shipped', 'Singapore', 'Singapore', 'Urgent', CURRENT_TIMESTAMP);

-- ============================================
-- ORDER ITEMS
-- ============================================
INSERT INTO order_items VALUES
(1, 1, 1, 2, 1200.00),
(2, 1, 3, 1, 150.00),
(3, 2, 2, 3, 800.00),
(4, 3, 4, 1, 300.00),
(5, 4, 5, 2, 80.00),
(6, 5, 1, 1, 1200.00);

-- ============================================
-- SHIPMENTS (include delays + failure)
-- ============================================
INSERT INTO shipments VALUES
-- ON TIME
(1, 1, 1, 1, '2024-01-02', '2024-01-04', 'Delivered', 50.00, 'TRK001', CURRENT_TIMESTAMP),

-- LATE DELIVERY
(2, 2, 2, 3, '2024-01-03', '2024-01-08', 'Delivered', 30.00, 'TRK002', CURRENT_TIMESTAMP),

-- FAILED DELIVERY
(3, 3, 1, 2, '2024-01-04', NULL, 'Failed', 20.00, 'TRK003', CURRENT_TIMESTAMP),

-- CANCELLED ORDER (no shipment really but included for realism)
(4, 4, 2, 3, NULL, NULL, 'Cancelled', 0.00, 'TRK004', CURRENT_TIMESTAMP),

-- IN TRANSIT (PENDING)
(5, 5, 1, 1, '2024-01-06', NULL, 'In Transit', 60.00, 'TRK005', CURRENT_TIMESTAMP);

-- ============================================
-- RETURNS (some orders returned)
-- ============================================
INSERT INTO returns VALUES
(1, 2, '2024-01-10', 'Damaged', 800.00, 'Refunded', CURRENT_TIMESTAMP),
(2, 3, '2024-01-11', 'Customer Dissatisfaction', 300.00, 'Approved', CURRENT_TIMESTAMP);

