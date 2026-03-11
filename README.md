# SQL-PoweBI-Ecommerce-project
This project demonstrates an end-to-end data analytics workflow using SQL and Power BI. The dataset was stored and managed in a SQL database, then connected to Power BI to build an interactive dashboard that analyzes revenue, orders, customer insights, and product performance across different cities and categories.

**Creating the Customers Table**



create table customers
(
customer_id INT primary key,
customer_name varchar(50),
city varchar(50),
signup_date date
);


**Creating the Products Table**

This table stores product details such as product name, category, and price.

create table products
(
product_id INT primary key,
product_name varchar(50),
category varchar(50),
price decimal(10,2)
);


**Modifying Product Price Column**
alter table products 
modify column price decimal(10,2);



**Creating the Orders Table**

This table stores order information.

create table orders
(
order_id INT primary key,
customer_id INT,
order_date date,
foreign key (customer_id) references customers(customer_id)
);


**Creating the Order Details Table**

This table stores the products included in each order.

create table order_details
(
order_detail_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);




**Inserting Customer Data**

Customer records are inserted into the customers table.

Example:

Insert into customers values
(1,'Rahul','Mumbai','2023-01-10'),
(2,'Priya','Delhi','2023-02-15');


**Inserting Product Data**

Product information is inserted into the products table.

Example:

Insert into products values
(101,'Laptop','Electronics',70000);



**Inserting Order Records**

Order data is inserted into the orders table.

Example:

INSERT INTO orders VALUES
(1001,1,'2024-01-10');



**Inserting Order Transaction Details**

Order items and quantities are stored in order_details.

Example:

INSERT INTO order_details VALUES
(1,1001,101,1);


 **Calculating Total Revenue**
select SUM(products.price * order_details.quantity) AS Total_revenue
from products
join order_details
on products.product_id = order_details.product_id;


**Revenue by Product**
select products.product_name,
sum(products.price * order_details.quantity) AS Total_revenue
from products
join order_details
on products.product_id = order_details.product_id
group by products.product_name;



 **Top Customers by Spending**
select customer_name,
sum(p.price * od.quantity) AS revenue
from customers c
join orders o
on c.customer_id = o.customer_id
join order_details od
on o.order_id = od.order_id
join products p
on od.product_id = p.product_id
group by customer_name
order by revenue desc;


**Sales by Category**
select products.category,
sum(products.price * order_details.quantity) AS Total_revenue
from products
join order_details
on products.product_id = order_details.product_id
group by category;



 **Monthly Sales Trend**
select date_format(o.order_date,'%Y-%m') AS month,
sum(p.price * od.quantity) AS Total_revenue
from orders o
join order_details od
on o.order_id = od.order_id
join products p
on p.product_id = od.product_id
group by month;



**Average Order Value**
select avg(order_total) as avg_order_value
from (
select o.order_id,
sum(p.price * od.quantity) AS order_total
from orders o
join order_details od
on o.order_id = od.order_id
join products p
on p.product_id = od.product_id
group BY order_id
)t;



**Most Popular Product**
select product_name,
sum(od.quantity) as total_quantity
from products p
join order_details od
on od.product_id = p.product_id
group by product_name
order by total_quantity desc
limit 1;



**Customer Order Frequency**
select customer_name,
count(o.order_id) as total_orders
from customers c
left join orders o
on c.customer_id = o.customer_id
group by customer_name;

**Dashboard Features**

The Power BI dashboard provides the following insights:
**Key Performance Indicators (KPIs)**
Total Revenue
Total Orders
Total Customers
Average Order Value

**Visualizations**
Sales Quantity by Product – identifies top selling products
Total Revenue by City – compares sales across cities
Revenue by Category – shows category contribution
Quantity Trend by Day – tracks sales trend over time
Top Customer by Revenue – highlights highest spending customer

**Filters**
City slicer to analyze sales by location
