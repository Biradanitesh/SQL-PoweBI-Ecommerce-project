create database ECommerce_dataset;
use ECommerce_dataset;

create table customers
(
customer_id INT primary key,
customer_name varchar(50),
city varchar(50),
signup_date date
);

create table products
(
product_id INT primary key,
product_name varchar(50),
category varchar(50),
price decimal(10,2)
);

create table orders
(
order_id INT primary key,
customer_id INT,
order_date date,
foreign key (customer_id) references customers(customer_id)
);

create table order_details
(
order_detail_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

Insert into customers values
(1,'Rahul','Mumbai','2023-01-10'),
(2,'Priya','Delhi','2023-02-15'),
(3,'Amit','Bangalore','2023-03-20'),
(4,'Sneha','Hyderabad','2023-04-05');
(5,'Arjun','Pune','2023-05-12'),
(6,'Meera','Chennai','2023-06-18'),
(7,'Ravi','Kolkata','2023-07-20'),
(8,'Anita','Delhi','2023-08-25');

Insert into products values
(101,'Laptop','Electronics',70000),
(102,'Headphones','Electronics',2000),
(103,'Shoes','Fashion',3000),
(104,'Watch','Accessories',5000);
(105,'Smartphone','Electronics',40000),
(106,'Backpack','Fashion',1500),
(107,'Sunglasses','Accessories',2500),
(108,'Tablet','Electronics',30000);


INSERT INTO orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-11'),
(1003,1,'2024-02-01'),
(1004,3,'2024-02-05');
(1005,4,'2024-02-10'),
(1006,5,'2024-02-12'),
(1007,6,'2024-02-15'),
(1008,7,'2024-02-18'),
(1009,8,'2024-02-20');


INSERT INTO order_details VALUES
(1,1001,101,1),
(2,1001,102,2),
(3,1002,103,1),
(4,1003,104,1),
(5,1004,101,1);
(6,1005,105,1),
(7,1006,106,2),
(8,1007,108,1),
(9,1008,107,3),
(10,1009,105,1);


#Total Revenue?
select SUM(products.price * order_details.quantity) AS Total_revenue from products
join order_details on products.product_id=order_details.product_id;

#Revenue by Product?

select products.product_name,sum(products.price * order_details.quantity) AS Total_revenue from products
join order_details on products.product_id=order_details.product_id
group by products.product_name
order by Total_revenue;

#Top Customers by Spending?

select customer_name,sum(p.price * od.quantity) AS revenue from customers as c
join orders as o `ecommerce_dataset`
on c.customer_id=o.customer_id
join order_details as od 
on o.order_id=od.order_id
join products as p
on od.product_id=p.product_id
group by customer_name
order by revenue;

#Sales by Category?

select products.category,sum(products.price * order_details.quantity) AS Total_revenue from products
join order_details on products.product_id=order_details.product_id
group by category;

#Monthly Sales Trend?

select date_format(o.order_date,'%Y-%m') AS month ,sum(p.price * od.quantity) AS Total_revenue from orders as o
join order_details as od
on o.order_id=od.order_id
join products as p
on p.product_id=od.product_id
group by month
order by month;

#Average Order Value?

select avg(order_total) as avg_order_value from (
select o.order_id,sum(p.price * od.quantity) AS order_total from orders o
join order_details od on o.order_id=od.order_id
join products p on p.product_id = od.product_id
group BY order_id)t;

# Most Popular Product?

select product_name,sum(od.quantity) as total_quantity from products as p
join order_details od on od.product_id=p.product_id
group by product_name
order by total_quantity desc
LIMIT 1;

#Customer Order Frequency?

select customer_name,count(o.order_id) as total_orders from customers c
left join orders o on c.customer_id=o.customer_id
group by customer_name
order by total_orders desc;

