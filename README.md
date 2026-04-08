# Olist-E-Commerce-Revenue-Analysis

Project Overview
This project analyses revenue, sales, and order fulfilment patterns for Olist — a Brazilian e-commerce marketplace operating across 27 states. The goal is to identify what is driving revenue, where it is concentrated, and where operational risks such as cancellations exist.
The analysis is structured around four business questions, each answered through SQL queries and visualised in a single-page Power BI dashboard.
Tools Used: SQL Server (T-SQL) · Power BI Desktop · Kaggle (Olist Dataset)
Time Period: January 2017 – December 2018

Note: 2016 data excluded as the dataset contains only partial year records (Sep–Dec 2016), which would skew year-on-year comparisons.

Business Question: 
1. Is Olist's monthly revenue growing year on year?
2. Which product categories drive the most revenue?
3. How many orders are being cancelled vs delivered?
4. Which states generate the most revenue?Top 10 Bar Chart?

Dataset
Source: Olist E-Commerce Dataset — Kaggle
FileDescription:
1. olist_orders_dataset.csv : Order details including status and timestamps
2. olist_order_items_dataset.csv : Item level pricing per order
3. olist_products_dataset.csv : Product details and category names
4. olist_customers_dataset.csv : Customer location — state and city
5. olist_product_category_name_translation.csv : Portuguese to English category name mapping

Data Model:

<img width="761" height="441" alt="Data_Model" src="https://github.com/user-attachments/assets/8a9c67e0-7dc8-4a53-98aa-2c014eee4d22" />

Key Findings:
1. Revenue grew significantly year on year
2018 revenue outpaced 2017 across most months. However, seasonal patterns differ between years — 2017 peaked in Q4 (Oct–Dec) consistent with end of year shopping behaviour, while 2018 peaked in Q2 (Apr–Jun), suggesting a shift in buying patterns or promotional activity.
   
2. Health & Beauty is the top revenue generating category
Health & Beauty led overall revenue, followed closely by Watches & Gifts. These lifestyle categories outperformed electronics — indicating Olist's customer base skews toward personal care and gifting rather than high-ticket electronics.

3. Geographic revenue concentration is a business risk
São Paulo (SP) dominates revenue heavily across both years. While expected given population size, this level of concentration represents a geographic dependency risk — a logistics or economic disruption in SP would disproportionately impact Olist's overall revenue.

4. Cancellation rates are low but worth monitoring
Cancelled and unavailable orders represent a small percentage of total orders month on month. No significant spike was found in Q2 as initially hypothesised — cancellation rates remained relatively stable across both years.

Analytical Decisions:
1.Delivered orders only used for revenue calculations — cancelled and unavailable orders excluded to avoid inflating revenue figures
2.Cancelled and unavailable orders grouped together — both represent unfulfilled orders from a business perspective and are treated as a single "unfulfilled" category in the cancellation analysis
3.Year slicer in Power BI disconnected from YoY line chart — intentional design decision to preserve year-on-year comparison while allowing other visuals to be filtered by year
4.Cancellation rate calculated against total monthly orders — not against invoiced orders, which would produce a misleading denominator

Dashboard:

<img width="1307" height="728" alt="Olist_Dashboard" src="https://github.com/user-attachments/assets/4f6fdffc-4238-497c-980b-0a96e702add3" />







