-- 1. Retrieving all users:

Delimiter //

create procedure getAllUsers()
begin 
select * from users;
end//

call getAllusers();


-- 2. get orders by user_id


Delimiter //

create procedure getOrdersByUsers(in userid int)
begin 
select * from orders where user_id=userid;
end //

CALL getOrdersByUsers(102);




-- 3. update order status

Delimiter //
create procedure updateorderstatus(
in orderid int,
in newstatus varchar(20)
)

begin 
update orders
set status=newstatus
where order_id=orderid;
end //

call updateorderstatus(5,'shipped');


-- 4. Delete an order by id

delimiter //
create procedure DeleteorderbyId(in orderid int)
begin
delete from orders where order_id=orderid;
end //

call deleteorderbyId(105);
