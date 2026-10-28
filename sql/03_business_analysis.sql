
-- =========================================================
-- 03 - BUSINESS ANALYSIS
-- Project: E-commerce Analytics with SQL
-- Database: PostgreSQL
--
-- Business rule:
-- Only orders with status 'delivered' count as completed sales.
-- Revenue = quantity * unit_price.
-- =========================================================


-- 1. KEY BUSINESS METRICS
-- Total revenue, delivered orders, unique customers
-- and average order value.

WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'delivered'
    GROUP BY o.order_id, o.customer_id
)
SELECT
    COUNT(*) AS delivered_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(order_total) AS total_revenue,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM order_totals;


-- 2. REVENUE BY PRODUCT CATEGORY
-- Which categories generate the most revenue?

SELECT
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;


-- 3. PRODUCT PERFORMANCE
-- Compare products by units sold and revenue.

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_revenue DESC;


-- 4. REPEAT CUSTOMERS
-- Find customers with more than one delivered order.

WITH order_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'delivered'
    GROUP BY o.order_id, o.customer_id
)
SELECT
    c.customer_id,
    c.name,
    COUNT(ot.order_id) AS delivered_orders,
    SUM(ot.order_total) AS total_spent
FROM order_totals ot
JOIN customers c
    ON ot.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(ot.order_id) > 1
ORDER BY total_spent DESC;


-- 5. MONTHLY REVENUE
-- Track revenue over time.

SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY sales_month;


-- 6. PRODUCT RANKING WITHIN EACH CATEGORY
-- Rank products by revenue using a window function.

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.status = 'delivered'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
)
SELECT
    product_name,
    category,
    total_revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS category_rank
FROM product_sales
ORDER BY category, category_rank;
