-- Function to calculate total with tax (for ex: 5%)--

delimiter //

create function calculatetotalwithTax(baseAmount decimal(10,2))

returns decimal(10,2)
deterministic
begin 
return baseAmount*1.05;
end //
delimiter //

SELECT order_id, total_amount, calculatetotalwithTax(total_amount) AS with_tax
FROM Orders;