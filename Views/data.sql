
--shows who placed the order, when, how much, and whether it was paid.
CREATE VIEW order_summary_view AS
SELECT 
    o.order_id,
    u.full_name,
    o.order_date,
    o.status AS order_status,
    o.total_amount,
    p.method AS payment_method,
    p.status AS payment_status
FROM 
    orders o
JOIN users u ON o.user_id = u.user_id
LEFT JOIN payments p ON o.order_id = p.order_id;

SELECT * FROM order_summary_view;
-- aanother way of selecting a view--
SELECT * 
FROM order_summary_view
WHERE payment_status = 'Paid'
ORDER BY order_date DESC;



--Lists users who have spent the most money.

CREATE VIEW top_customers_view AS
SELECT 
    u.user_id,
    u.full_name,
    SUM(o.total_amount) AS total_spent,
    COUNT(o.order_id) AS total_orders
FROM 
    users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY total_spent DESC;


SELECT * 
FROM top_customers_view
LIMIT 5;


--Shows total quantity sold and total revenue for each product.
CREATE VIEW product_sales_view AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM 
    products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC;


SELECT * 
FROM product_sales_view
WHERE total_revenue > 10000;


