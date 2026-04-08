/* 
Analysis : Monthly Revenue Trend (YoY)
Business Question: Is Olist's monthly revenue growing month on month across years? 
Hypothesis: Revenue peaks in Q4 (Oct-Dec) driven by seasonal shopping events in Brazil
Output:Used in Power Bi Line Chart (YoY)
Datset: Olist Orders Dataset, Olist Order Items Dataset
*/


select * from dbo.olist_orders_dataset;

-- Query 1: Monthly Revenue by Year--
-- Revenue calculated considering delivered orders only-- 
--	2016 excluded as it contains only partial year data-- 

select
	Year(order_purchase_timestamp) as Year,
	MONTH(order_purchase_timestamp) as Month,
	sum(price) as Total_Revenue 

from dbo.olist_order_items_dataset
join dbo.olist_orders_dataset
on dbo.olist_order_items_dataset.order_id = dbo.olist_orders_dataset.order_id

where dbo.olist_orders_dataset.order_status = 'delivered'
and 
dbo.olist_orders_dataset.order_purchase_timestamp IN (2017,2018) 

group by Year(order_purchase_timestamp), MONTH(order_purchase_timestamp)
order by Year(order_purchase_timestamp), MONTH(order_purchase_timestamp)
;

--Query2: Percentage contribution of each month to the yearly revenue --
-- Business Purpose: Identifies which months drive disproportionate share of annual revenue -- 

With Percentage_Calculation as (
	select
		Year(order_purchase_timestamp) as Year1,
		MONTH(order_purchase_timestamp) as Month1,
		sum(price) as Total_Revenue
		from dbo.olist_order_items_dataset
		join dbo.olist_orders_dataset
		on dbo.olist_order_items_dataset.order_id = dbo.olist_orders_dataset.order_id

where dbo.olist_orders_dataset.order_status = 'delivered'
and 
dbo.olist_orders_dataset.order_purchase_timestamp between '2017-01-01' and '2018-12-31'
group by Year(order_purchase_timestamp), MONTH(order_purchase_timestamp)
)

select 	
	Year1,
	Month1,
	Total_Revenue,

	-- Percentage calculated against the yearly total only
    -- so Jan-Dec of each year independently adds up to 100%

	Round(
	Total_Revenue / sum(Total_Revenue) over (partition by year1) * 100 ,2
	) as Revenue_Percentage
	from Percentage_Calculation 
	order by year1,Month1;