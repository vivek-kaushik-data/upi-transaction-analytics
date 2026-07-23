-- Create database
CREATE DATABASE IF NOT EXISTS upi_analysis;
USE upi_analysis;

-- Create table
CREATE TABLE upi_apps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    app_name VARCHAR(100) NOT NULL,
    total_volume_mn DECIMAL(10,2),
    total_value_cr DECIMAL(15,2),
    month VARCHAR(10),
    year INT,
    category VARCHAR(20)
);

-- Data Inspection
select * FROM upi_apps
limit 10;

-- Total number of transactions by month in millions
SELECT month,
	   year,
       SUM(total_volume_mn) AS total_transactions_mn
FROM upi_apps
GROUP BY month,year
ORDER BY total_transactions_mn desc;

-- YoY Growth Percentage
with yearly as(
SELECT year,
       SUM(total_volume_mn) AS total_transactions_mn,
       lag(sum(total_volume_mn)) over(order by year) as previous_value
FROM upi_apps
GROUP BY year)
select year,
	   round((total_transactions_mn-coalesce(previous_value,0))*100/coalesce(previous_value,1),2) as YoY_growth_perct
from yearly;

-- Top 5 most used apps
select app_name,
       sum(total_volume_mn) as Total_transactions_mn
from upi_apps
group by app_name
order by Total_transactions_mn desc
limit 5;

-- Finding App Domminance
select category,
	   sum(total_volume_mn) AS total_transactions_mn,
       sum(total_value_cr) as total_amount_cr
from upi_apps
group by category;

-- Top 5 Apps with highest avg value per transaction
select app_name,
       round((sum(total_value_cr)/sum(total_volume_mn))*10,2) as avg_value_per_txn_rupees
from upi_apps
group by app_name
order by avg_value_per_txn_rupees desc
limit 5;

-- Newly introduced apps in digital Payments
select  distinct app_name
from upi_apps u
where not exists (
                  select 1
                  from upi_apps ua
                  where ua.year in (2022,2023,2024)
                  and u.app_name = ua.app_name);

-- Seasonal pattern independent of year
select month,
       round(avg(total_volume_mn),2) as avg_transactions
from upi_apps
group by month
order by avg_transactions desc;

-- % share of apps in upi transactions
select app_name,
       round(sum(total_volume_mn)*100.0/(
										 select sum(total_volume_mn)
										 from upi_apps),2) as share
from upi_apps
group by app_name
order by share desc
limit 10;

-- Fast growing apps
with first_year as(
				   select app_name,
                   sum(total_volume_mn) as first_txns
                   from upi_apps
                   where year = 2022
                   group by app_name),
last_year as(
             select app_name,
             sum(total_volume_mn) as last_txns
             from upi_apps
             where year = 2025
             group by app_name)
select f.app_name,
       round((l.last_txns-f.first_txns)*100.0/f.first_txns,2) as growth
from first_year f
join last_year l on f.app_name = l.app_name
order by growth desc;

-- Top Consistent apps
select t.app_name from
(select app_name,
        year,
        rank() over(partition by year order by sum(total_volume_mn) desc) as rnk 
        from upi_apps 
        group by year,app_name) t
where t.rnk <= 10
group by t.app_name
having count(distinct t.year) >= 4;
