use `pizzasales`;
select * from pizza_data;

select count(*) from pizza_data;

--DATA CLEANING--
select count(*) as total_rows, sum(case when order_date is null then 1 else 0 end) as null_order_date,
sum(case when order_time is null then 1 else 0 end) as null_order_time from pizza_data;


SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN pizza_name IS NULL THEN 1 ELSE 0 END) AS missing_pizza_name,
    SUM(CASE WHEN total_price IS NULL THEN 1 ELSE 0 END) AS missing_total_price
FROM pizza_data;


--Removing duplicates--
select distinct * from pizza_data;

CREATE TABLE pizza_data_cleaned AS
SELECT DISTINCT *
FROM pizza_data
WHERE total_price IS NOT NULL;

--Total Revenue--
select sum(total_price) as total_revenue from pizza_data;

--Total Pizza Sold--
select sum(quantity) as total_pizza_sold from pizza_data;

--Total Orders--
select sum(order_id) as total_orders from pizza_sales;

--Average Order value--
select sum(total_price)/count(distinct order_id) as average_orders from pizza_data;

--% of Total revenue by pizza category--
SELECT pizza_category, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_data), 2) AS revenue_percentage
FROM pizza_data GROUP BY pizza_category ORDER BY revenue_percentage DESC;

--Revenue contribution by pizza size--
SELECT pizza_size, SUM(total_price) AS total_revenue, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_data), 2) 
AS revenue_percentage FROM pizza_data GROUP BY pizza_size ORDER BY total_revenue DESC;

--Monthly Sales Trend
select monthname(order_date) as month_name, sum(total_price) as monthly_revenue from pizza_data
 group by month(order_date), monthname(order_date) order by min(order_date);
 
 
 --Most popular pizza category by size--
 select pizza_category, pizza_size, sum(quantity) as total_sold from pizza_data group by pizza_category, pizza_size 
 order by total_sold desc;
 

--Top 5 pizzas by total Orders--
select pizza_name, count(distinct(order_id)) as total_orders from pizza_data group by pizza_name
order by total_orders desc limit 5; 

--Bottom 5 pizzas by total orders--
select pizza_name, count(distinct(order_id)) as total_orders from pizza_data group by pizza_name
order by total_orders asc limit 5; 

--Top 10 pizzas by total revenue--
select pizza_name, sum(total_price) as total_revenue from pizza_data 
group by pizza_name order by total_revenue desc limit 10;

--Bottom 10 pizzas by revenue--
select pizza_name, sum(total_price) AS Total_Revenue from pizza_sales
group by pizza_name order by Total_Revenue asc limit 10;

--Total revenue & no.of orders by weekday--
SELECT DAYNAME(order_date) AS weekday_name, SUM(total_price) AS total_revenue, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_data GROUP BY weekday_name
ORDER BY FIELD(weekday_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
 
 --Total revenue by pizza category--
 SELECT pizza_category, SUM(total_price) AS total_revenue FROM pizza_data GROUP BY pizza_category ORDER BY total_revenue DESC;
 
 SELECT 
    DAYNAME(order_date) AS weekday_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_data
GROUP BY weekday_name
ORDER BY FIELD(weekday_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

