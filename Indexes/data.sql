
-- INDEXES--

CREATE INDEX idx_order_date ON orders(order_date);
 EXPLAIN SELECT * FROM orders WHERE order_date >= '2025-01-01';
 SHOW INDEX FROM orders;


CREATE INDEX idx_user_id ON orders(user_id);
EXPLAIN SELECT * FROM orders WHERE user_id = 101;


CREATE INDEX idx_product_id ON order_items(product_id);
EXPLAIN SELECT * FROM order_items WHERE product_id = 3;


CREATE INDEX idx_payment_status ON payments(status);
 EXPLAIN SELECT * FROM payments WHERE status = 'Paid';
