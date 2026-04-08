/*
Analysis: Revenue by State
Business Question: Which Brazilian states generate the most revenue for Olist?
Hypothesis  : São Paulo (SP) dominates revenue due to higher population density and urbanisation geographic concentration risk for Olist
Output      : Used in Power BI Bar Chart (Top 10 States)
Dataset     : olist_orders_dataset, olist_order_items_dataset,
              olist_customers_dataset
*/


-- QUERY 1: Revenue by State and City
-- Delivered orders only -- consistent with all other revenue calculations in this analysis
-- 2016 excluded consistent with other analyses


SELECT
    c.customer_state,
    c.customer_city,
    SUM(oi.price) AS Total_Revenue
FROM dbo.olist_orders_dataset o
JOIN dbo.olist_order_items_dataset oi
    ON oi.order_id = o.order_id
JOIN dbo.olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND YEAR(o.order_purchase_timestamp) IN (2017, 2018)
GROUP BY
    c.customer_state,
    c.customer_city
ORDER BY Total_Revenue DESC;


-- QUERY 2: Revenue by State Only (Top 10)
-- City removed from grouping to get state level 
-- Top 10 filter applied to focus on highest revenue generating states


SELECT TOP 10
    c.customer_state,
    SUM(oi.price) AS Total_Revenue,
    RANK() OVER (ORDER BY SUM(oi.price) DESC) AS Revenue_Rank
FROM dbo.olist_orders_dataset o
JOIN dbo.olist_order_items_dataset oi
    ON oi.order_id = o.order_id
JOIN dbo.olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND YEAR(o.order_purchase_timestamp) IN (2017, 2018)
GROUP BY c.customer_state
ORDER BY Total_Revenue DESC;
