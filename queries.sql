-- ==========================================
-- JOIN QUERIES
-- ==========================================

-- 1. INNER JOIN: orders + customers
SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 2. JOIN: order_items + products
SELECT oi.order_item_id, oi.order_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;

-- 3. LEFT JOIN: customers + orders
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;


-- ==========================================
-- CTE QUERY
-- ==========================================

-- Customers with spend above average
WITH customer_spend AS (
  SELECT c.customer_id, c.customer_name, 
         NVL(SUM(oi.quantity * p.price), 0) AS total_spend
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  LEFT JOIN order_items oi ON o.order_id = oi.order_id
  LEFT JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_spend
FROM customer_spend
WHERE total_spend > (SELECT AVG(total_spend) FROM customer_spend)
ORDER BY total_spend DESC;


-- ==========================================
-- WINDOW-FUNCTION QUERIES
-- ==========================================

-- 1. Rank customers by total amount spent
WITH customer_totals AS (
  SELECT c.customer_id, c.customer_name, 
         NVL(SUM(oi.quantity * p.price), 0) AS total_spent
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  LEFT JOIN order_items oi ON o.order_id = oi.order_id
  LEFT JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_spent,
       DENSE_RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM customer_totals;

-- 2. Number each customer's orders chronologically
SELECT o.order_id, c.customer_name, o.order_date,
       ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS order_sequence
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 3. Running total of revenue over time
WITH order_totals AS (
  SELECT o.order_id, o.order_date, 
         SUM(oi.quantity * p.price) AS order_revenue
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY o.order_id, o.order_date
)
SELECT order_id, order_date, order_revenue,
       SUM(order_revenue) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_revenue
FROM order_totals
ORDER BY order_date;

-- 4. Days between current and previous order
SELECT o.customer_id, c.customer_name, o.order_id, o.order_date,
       LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS prev_order_date,
       o.order_date - LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS days_between_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.customer_id, o.order_date;