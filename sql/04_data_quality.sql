
-- =========================================================
-- 04 - DATA QUALITY CHECKS
-- Project: E-commerce Analytics with SQL
-- Database: PostgreSQL
--
-- Goal:
-- Identify potential data quality issues before analysis.
-- =========================================================


-- 1. CHECK FOR CUSTOMERS WITHOUT EMAIL
-- Expected result: zero rows.

SELECT
    customer_id,
    name,
    email
FROM customers
WHERE email IS NULL
   OR TRIM(email) = '';


-- 2. CHECK FOR INVALID PRODUCT PRICES
-- Expected result: zero rows.

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price < 0
   OR price IS NULL;


-- 3. CHECK FOR ORDER ITEMS WITH INVALID QUANTITIES
-- Expected result: zero rows.

SELECT
    order_item_id,
    order_id,
    product_id,
    quantity
FROM order_items
WHERE quantity <= 0
   OR quantity IS NULL;


-- 4. CHECK FOR ORDERS WITHOUT ITEMS
-- These orders may indicate incomplete transactions.

SELECT
    o.order_id,
    o.order_date,
    o.status
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;


-- 5. CHECK FOR INVALID ORDER STATUSES
-- Expected result: zero rows.

SELECT
    order_id,
    status
FROM orders
WHERE status NOT IN (
    'pending',
    'paid',
    'shipped',
    'delivered',
    'cancelled'
)
   OR status IS NULL;


-- 6. CHECK FOR DUPLICATE CUSTOMER EMAILS
-- Expected result: zero rows.

SELECT
    LOWER(TRIM(email)) AS normalized_email,
    COUNT(*) AS occurrences
FROM customers
WHERE email IS NOT NULL
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;


-- 7. CHECK FOR ORDER ITEMS WITH INVALID REFERENCES
-- These checks help detect orphan records.

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_id IS NULL
   OR p.product_id IS NULL;


-- 8. DATASET SUMMARY
-- Quick overview of the current dataset.

SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM order_items) AS total_order_items;
