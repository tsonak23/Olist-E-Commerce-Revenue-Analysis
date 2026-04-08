
-- Quick check to understand available order statuses
-- before filtering -- ensures no valid status is excluded

select distinct(order_status) from dbo.olist_orders_dataset;


/* Analysis:  Revenue by Category ( Top 10 )
Business Question: Whcic categories which drive most revenue?
Hypothesis: Health & Beauty and lifestyle categories drive highest revenue
Output: Used in Power BI Bar Chart (Top 10 Categories) 
Dataset: olist_products_dataset ,olist_order_items_dataset ,olist_orders_dataset
*/

-- QUERY 1: Revenue by Category Split by Year
-- CASE WHEN used to pivot revenue into separate 
-- year columns for direct YoY comparison per category
-- TOP 10 ordered by 2018 revenue -- most recent year 
-- used as primary sort to reflect current performance
-- NULL categories excluded as they have no business meaning


select TOP 10 
p.product_category_name,
sum( case when year( o.order_purchase_timestamp) = 2017 
then oi.price
else 0 end)
as total_revenue_2017,

sum( case when year( o.order_purchase_timestamp) = 2018
then oi.price
else 0 end)
as total_revenue_2018

from dbo.olist_products_dataset p
join dbo.olist_order_items_dataset oi
on p.product_id = oi.product_id
join dbo.olist_orders_dataset o on oi.order_id = o.order_id
where o.order_status = 'delivered'
and p.product_category_name IS NOT NULL

group by p.product_category_name 
order by total_revenue_2018 desc;


-- QUERY 2: Revenue by Category with Combined Total
-- Alternative approach using CTE for better readability
-- Combined total added to rank categories across 
-- both years together -- more balanced than single year sort
-- Note: TOP 10 applied inside CTE first, then total calculated outside 
-- ensures consistent category set

WITH Category_Revenue AS (
    SELECT TOP 10
        p.product_category_name,
        SUM(CASE 
                WHEN YEAR(o.order_purchase_timestamp) = 2017 
                THEN oi.price 
                ELSE 0 
            END) AS Total_Revenue_2017,
        SUM(CASE 
                WHEN YEAR(o.order_purchase_timestamp) = 2018 
                THEN oi.price 
                ELSE 0 
            END) AS Total_Revenue_2018
    FROM dbo.olist_products_dataset p
    JOIN dbo.olist_order_items_dataset oi
        ON p.product_id = oi.product_id
    JOIN dbo.olist_orders_dataset o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    AND p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
    -- Ordering by combined total inside CTE to ensure
    -- Top 10 reflects overall performance not just 2018
    ORDER BY (
        SUM(CASE WHEN YEAR(o.order_purchase_timestamp) = 2017 
            THEN oi.price ELSE 0 END) +
        SUM(CASE WHEN YEAR(o.order_purchase_timestamp) = 2018 
            THEN oi.price ELSE 0 END)
    ) DESC
)
SELECT
    product_category_name,
    Total_Revenue_2017,
    Total_Revenue_2018,
    -- Combined total used for final ranking -- gives 
    -- more balanced view than single year ordering
    (Total_Revenue_2017 + Total_Revenue_2018) AS Total_Revenue
FROM Category_Revenue
ORDER BY Total_Revenue DESC;
