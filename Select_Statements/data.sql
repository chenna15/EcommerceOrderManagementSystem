
-- ALL USERS AND THEIR COUNT---------
select u.user_id, u.full_name, count(order_id) as total_orders
from users u right join orders o on u.user_id=o.user_id
group by u.user_id, u.full_name;


-- TOP 5 PRODUCTS BY TOTAL QUANTITY SOLD-----------
----------------------------------------

select p.product_name, sum(oi.quantity) as total_sold
from order_items oi 
join products p on oi.product_id=p.product_id
group by p.product_id, p.product_name
order by total_sold desc limit 5;



-- TOTA REVENUE BY PAYMENT METHODS------
-----------------------------------

SELECT METHOD, SUM(AMOUNT) AS TOTAL_REVENU
FROM PAYMENTS WHERE STATUS='failed' group by method;



-- PENDING ORDERS WITH USER INFO---
---------------------------------

select order_id, full_name,
order_date, status from orders o join users u on o.user_id=u.user_id
where o.status='pending';


-- PRODUCT STOCK STATUS (low stock alert<40)

select product_name,
stock from products where stock<=40;


-- DAILY ORDER SUMMARY (LAST 7 DAYS)

select date(order_date) as order_day,
count(order_id) as total_orders,
sum(total_amount) as total_sales
 from orders 
 where order_date>=current_date()-interval 7 day
 group by order_day
 order by order_day desc;





 -- FIND UNPAID OF FAILED PAYMENTS------
 ---------------------------------
 
 SELECT p.payment_id, o.order_id, u.full_name, p.amount, p.status
 from payments p 
 join orders o on p.order_id=o.order_id
 join users u on o.user_id=u.user_id
 where p.status in('failed','pending');
