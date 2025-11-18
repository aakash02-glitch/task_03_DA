-- Create Database
CREATE DATABASE walmart_sales;
USE walmart_sales;

-- Create Tables
-- 1. Sales
CREATE TABLE sales (
    store INT,
    date DATE,
    weekly_sales FLOAT,
    holiday_flag INT,
    temperature FLOAT,
    fuel_price FLOAT,
    cpi FLOAT,
    unemployment FLOAT
);

-- 2. Stores
CREATE TABLE stores (
    store INT PRIMARY KEY,
    type VARCHAR(5),
    size INT
);

-- Basic SELECT
SELECT * FROM sales;
SELECT store, date, fuel_price FROM sales;

SELECT * FROM stores;
SELECT store FROM stores;

-- WHERE Filtering
-- Holiday week sales
SELECT * FROM sales
WHERE holiday_flag = 1;

-- Temperature above 80°F
SELECT * FROM sales
WHERE temperature > 80;

-- ORDER BY
-- Top 10 highest weekly sales
SELECT store, date, weekly_sales
FROM sales
ORDER BY weekly_sales DESC
LIMIT 10;

-- GROUP BY Aggregation
-- Total sales per store
SELECT store, ROUND(SUM(weekly_sales),2) AS total_sales
FROM sales
GROUP BY store
ORDER BY total_sales DESC;

-- Average weekly sales per store
SELECT store, Round(AVG(weekly_sales),3) AS avg_sales
FROM sales
GROUP BY store
ORDER BY avg_sales DESC;

-- Holiday vs Non-holiday sales
SELECT holiday_flag, SUM(weekly_sales) AS total_sales
FROM sales
GROUP BY holiday_flag;

-- JOIN
-- Join sales with store details
SELECT s.store, t.type, t.size, s.date, s.weekly_sales
FROM sales s
JOIN stores t
ON s.store = t.store;

-- Average weekly sales by store type
SELECT t.type, AVG(s.weekly_sales) AS avg_sales
FROM sales s
JOIN stores t ON s.store = t.store
GROUP BY t.type
ORDER BY avg_sales DESC;

-- Date Functions
-- Month-wise average sales
SELECT MONTH(date) AS month, Round(AVG(weekly_sales),2) AS avg_monthly_sales
FROM sales
GROUP BY MONTH(date)
ORDER BY month;

-- LIMIT Function 
-- Highest CPI week
SELECT * FROM sales
ORDER BY cpi DESC
LIMIT 1;


-- Uses SELECT + WHERE + GROUP BY + SUM + ORDER BY + LIMIT
/* Find the top 3 store types that generated the highest total sales in the year 2010,
only for weeks where the temperature was above 60°F.
Show: store type, total sales.
Sort the result from highest to lowest.
Limit the output to 3 rows. */
SELECT t.type, Round(SUM(s.weekly_sales),3) AS total_sales
FROM sales s
JOIN stores t ON s.store = t.store
WHERE YEAR(s.date) = 2010
  AND s.temperature > 60
GROUP BY t.type
ORDER BY total_sales DESC
LIMIT 3;

