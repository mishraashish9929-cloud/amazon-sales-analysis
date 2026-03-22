-- AMAZON SALES ANALYSIS PROJECT
-- Tool: PostgreSQL / MySQL

-----------------------------------------
-- 1. DATA CLEANING
-----------------------------------------

-- Check for Nulls in Amount
SELECT COUNT(*) FROM amazon_sales WHERE Amount IS NULL;

-- Fix Nulls (Set to 0 or remove)
UPDATE amazon_sales SET Amount = 0 WHERE Amount IS NULL;

-- Remove Duplicates
DELETE FROM amazon_sales WHERE index NOT IN (
    SELECT MIN(index) FROM amazon_sales 
    GROUP BY "Order ID", SKU, Date
);

-----------------------------------------
-- 2. BUSINESS INSIGHTS
-----------------------------------------
--TOTAL SALES
SELECT SUM(Amount) AS total_revenue FROM amazon_sales;

--Monthly Sales Trend
SELECT DATE_TRUNC('month', Date) AS month, SUM(Amount) AS revenue
FROM amazon_sales
GROUP BY month ORDER BY month;

--Top 5 Products (Styles)
SELECT Style, SUM(Amount) AS revenue
FROM amazon_sales
GROUP BY Style ORDER BY revenue DESC LIMIT 5;

--Region-wise Sales (Top 5 States)
SELECT "ship-state", SUM(Amount) AS revenue
FROM amazon_sales
GROUP BY "ship-state" ORDER BY revenue DESC LIMIT 5;