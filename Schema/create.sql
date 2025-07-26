
#  1 users table
----------------
create table users (
user_id int auto_increment primary key,
full_name varchar(100) not null,
email varchar(100) unique not null,
password varchar(255) not null,
phone varchar(15),
address Text,

created_at TIMESTAMP DEFAULT current_timestamp
);

# 2 Categories table
--------------
create table categories (
category_id int auto_increment primary key,
category_name varchar(50) not null
);

# 3 products table
-----------------
create table products(

product_id int auto_increment primary key,
product_name varchar(50) not null,
category_id int,
price decimal(10,2) not null,
stock int not null,
description text,
foreign key (category_id) references categories (category_id)
);

# 4 orders table
----------------
create table orders(
order_id int auto_increment primary key,
user_id int,
order_date timestamp default current_timestamp,
status enum('pending','processing','shipped','delivered','cancelled') default 'pending',
total_amount decimal(10,2),
foreign key (user_id) references users(user_id)
);

# 5 order items table
---------------
create table order_items(
order_item_id int auto_increment primary key,
order_id int,
product_id int,
quantity int,
price decimal(10,2),
foreign key(order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

# 6 payments table
------------
create table payments(
payment_id int auto_increment  primary key,
order_id int,
payment_date timestamp default current_timestamp,
amount decimal(10,2),
method enum('Credit Card','UPI','Net Banking','COD'),
status enum('Paid','Failed','Pending') default'pending',
foreign key (order_id) references orders(order_id));
