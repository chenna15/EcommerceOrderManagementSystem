DELIMITER //

CREATE TRIGGER trg_reduce_stock_after_order
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;


-- Check Product Stock Before Order

SELECT * FROM Products WHERE product_id = 1;
-- Example Output: stock_quantity = 50;


 -- Insert into Order_Items (This is where the trigger fires)

INSERT INTO Order_Items (order_id, product_id, quantity)
VALUES (1, 1, 3);  -- 3 items of product_id 1

-- Check Product Stock After Order

SELECT stock_quantity FROM Products WHERE product_id = 1;
-- Example Output: 47 (auto-reduced by 3)



-- without trigger manually

-- Inserting Order Item
INSERT INTO Order_Items (order_id, product_id, quantity)
VALUES (2, 1, 5);

-- Now manually reducing stock
UPDATE Products
SET stock_quantity = stock_quantity - 5
WHERE product_id = 1;
