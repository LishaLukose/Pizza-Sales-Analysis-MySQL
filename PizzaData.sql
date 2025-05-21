create database pizzaanalytics;
use pizzaanalytics;
alter table pizza_sales modify column order_date date;
alter table pizza_sales modify column order_time time;
select * from pizza_sales;

#KPI-1 Total Revenue:
select concat('$ ',round(sum(total_price)/1000,2),'K') as TotalRevenue from pizza_sales;

#KPI-2 Average Order Value:
select round(sum(total_price)/count(distinct order_id),2) as AverageOrderValue from pizza_sales;

#KPI-3 Total Pizza Sold:
select sum(quantity) as TotalPizzaSold from pizza_sales;

#KPI-4 Total Orders:
select count(distinct order_id) as TotalOrders from pizza_sales;

#KPI-5 Average Pizzas per Order:
select round(sum(quantity)/count(distinct order_id),2) as AvgPizzasperOrder from pizza_sales;

#KPI-6 Daily Trend for Total Orders:
select dayname(order_date) as day_name,
count(distinct order_id) as total_orders
from pizza_sales group by day_name
order by field(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

#KPI-7 Hourly Trend for Total Orders:
select hour(order_time) as order_hour,
count(distinct order_id) as total_orders
from pizza_sales
group by order_hour
order by order_hour;

#KPI-8 Percentage of Sales by Pizza Category:
select pizza_category as PizzaCategory,
concat('$ ', round(sum(total_price)/1000, 2), ' K') as category_sales,
concat(round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales), 2),'%') as Percentage_of_Sales
from pizza_sales
group by pizza_category
order by percentage_of_sales desc;

#KPI-9 Percentage of Sales by Pizza Size:
select pizza_size as PizzaSize,
concat('$ ', round(sum(total_price)/1000, 2), ' K') as category_sales,
concat(round(sum(total_price) * 100 / (select SUM(total_price) from pizza_sales), 2),'%') as Percentage_of_Sales
from pizza_sales
group by PizzaSize
order by percentage_of_sales desc;

#KPI-10 Total Pizzas Sold by Pizza Category:
select pizza_category as PizzaCategory, sum(quantity) as TotalPizzasSold from pizza_sales
group by pizza_category
order by TotalPizzasSold desc;

#KPI-11 Top 5 Best Selling Pizza:
select pizza_name as PizzaName, sum(quantity) as TotalPizzasSold from pizza_sales
group by PizzaName
order by TotalPizzasSold desc limit 5;

#KPI-12 Bottom 5 Worst Selling Pizza:
select pizza_name as PizzaName, sum(quantity) as TotalPizzasSold from pizza_sales
group by PizzaName
order by TotalPizzasSold limit 5;