
/* Analysis: Orders Ordered Vs Refunded/Cancelled
   Business Question: How many orders are being cancelled/refunded vs completed?
   Hypothesis:Cancellation rates hyped in Q2 
   Output: Stacked Bar chart in Power BI
   Dataset: olist_orders_dataset
   */

-- Query1: To get the count of delivered and cancelled orders by month and year
-- Case when used to pivot orders into sepearate columns for delivered and cancelled orders.
--2016 excluded consistent with other analyses

select 
	year(order_purchase_timestamp ) as YearNo,
	month (order_purchase_timestamp) as MonthNo,
	count(case when  order_status = 'delivered' 
	then 1 end) as delivered_orders,

	count(case when  order_status IN ('canceled', 'unavailable') 
	then 1 end) as canceled_orders
	from dbo.olist_orders_dataset
	group by year(order_purchase_timestamp ),
	month (order_purchase_timestamp)
	order by year(order_purchase_timestamp ),
	month (order_purchase_timestamp);


	--Query2: Cancellation rate by month and year
	-- Alternative approach using CTE for better readability
	--Combined orders which are invoiced to get the percentage of cancellation against total orders


	With Cancellation_Rate As (
								select 
								year(order_purchase_timestamp ) as YearNo,
								month (order_purchase_timestamp) as MonthNo,
								count(case when  order_status = 'delivered' 
								then 1 end) as delivered_orders,
								count(case when  order_status IN ('canceled', 'unavailable') 
								then 1 end) as canceled_orders,
								count(order_status) as Total_orders

							from dbo.olist_orders_dataset
							where year(order_purchase_timestamp ) IN (2017,2018)
							group by year(order_purchase_timestamp ),month (order_purchase_timestamp)
							)

			select Yearno,
			MonthNo,
			Delivered_orders,
			Canceled_orders,
			Total_orders,
			round
			( 
			canceled_orders *100  / total_orders, 2 ) AS  Cancelation_Percentage
									from Cancellation_Rate

			order by YearNo,MonthNo 
			; 

