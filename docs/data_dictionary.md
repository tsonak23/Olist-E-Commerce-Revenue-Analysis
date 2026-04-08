## Dataset Overview

This dataset contains transactional data from a Brazilian e-commerce platform, capturing information related to customers, orders, products, and order-level details.

The dataset is used to analyze:

* Customer purchasing behavior
* Product category performance
* Revenue trends(YoY)
* State-wise revenue

---

## Tables Used in This Project

* Customers (`olist_customers_dataset`)
* Orders (`olist_orders_dataset`)
* Order Items (`olist_order_items_dataset`)
* Products (`olist_products_dataset`)
* Product Category Translation (`product_category_name_translation`)

---

## Tables Not Used

* Geolocation
* Order Payments
* Order Reviews

*These tables were excluded to maintain focus on sales, customer, and product analysis.*

---

# Data Dictionary

---

## Customers Dataset (`olist_customers_dataset`)

| Column Name              | Data Type | Description                                          | Example   | Nullable |
| ------------------------ | --------- | ---------------------------------------------------- | --------- | -------- |
| customer_id              | Text      | Unique identifier per order (changes for each order) | abcd123   | No       |
| customer_unique_id       | Text      | Unique identifier for a customer across orders       | uid_456   | No       |
| customer_zip_code_prefix | Integer   | First 5 digits of ZIP code                           | 11000     | No       |
| customer_city            | Text      | Customer’s city                                      | sao paulo | No       |
| customer_state           | Text      | Customer’s state (Brazil)                            | SP        | No       |

---

## Orders Dataset (`olist_orders_dataset`)

| Column Name                   | Data Type | Description                             | Example    | Nullable |
| ----------------------------- | --------- | --------------------------------------- | ---------- | -------- |
| order_id                      | Text      | Unique order identifier                 | ord_001    | No       |
| customer_id                   | Text      | Links to customers dataset              | abcd123    | No       |
| order_status                  | Text      | Order status (e.g., delivered, shipped) | delivered  | No       |
| order_purchase_timestamp      | DateTime  | Timestamp when order was placed         | 2017-10-02 | No       |
| order_approved_at             | DateTime  | Payment approval timestamp              | 2017-10-02 | Yes      |
| order_delivered_carrier_date  | DateTime  | Date when handed to courier             | 2017-10-04 | Yes      |
| order_delivered_customer_date | DateTime  | Date when delivered to customer         | 2017-10-10 | Yes      |
| order_estimated_delivery_date | DateTime  | Estimated delivery date                 | 2017-10-12 | No       |

---

## Order Items Dataset (`olist_order_items_dataset`)

| Column Name         | Data Type | Description                | Example    | Nullable |
| ------------------- | --------- | -------------------------- | ---------- | -------- |
| order_id            | Text      | Order identifier           | ord_001    | No       |
| order_item_id       | Integer   | Item sequence within order | 1          | No       |
| product_id          | Text      | Product identifier         | prod_789   | No       |
| seller_id           | Text      | Seller identifier          | sell_321   | No       |
| shipping_limit_date | DateTime  | Last date for shipping     | 2017-10-05 | No       |
| price               | Decimal   | Product price              | 120.50     | No       |
| freight_value       | Decimal   | Shipping cost              | 15.00      | No       |

---

## Products Dataset (`olist_products_dataset`)

| Column Name                | Data Type | Description                   | Example      | Nullable |
| -------------------------- | --------- | ----------------------------- | ------------ | -------- |
| product_id                 | Text      | Unique product identifier     | prod_789     | No       |
| product_category_name      | Text      | Product category (Portuguese) | beleza_saude | Yes      |
| product_name_lenght        | Integer   | Length of product name        | 40           | Yes      |
| product_description_lenght | Integer   | Description length            | 200          | Yes      |
| product_photos_qty         | Integer   | Number of product images      | 3            | Yes      |
| product_weight_g           | Integer   | Weight in grams               | 500          | Yes      |
| product_length_cm          | Integer   | Length in cm                  | 20           | Yes      |
| product_height_cm          | Integer   | Height in cm                  | 10           | Yes      |
| product_width_cm           | Integer   | Width in cm                   | 15           | Yes      |

---

## Product Category Translation (`product_category_name_translation`)

| Column Name                   | Data Type | Description                 | Example       | Nullable |
| ----------------------------- | --------- | --------------------------- | ------------- | -------- |
| product_category_name         | Text      | Category name in Portuguese | beleza_saude  | No       |
| product_category_name_english | Text      | Category name in English    | health_beauty | No       |

---

# Data Model Relationships

| From Table | Column                | To Table             | Column                   |
| ---------- | --------------------- | -------------------- | ------------------------ |
| Customers  | customer_id           | Orders               | customer_id              |
| Orders     | order_id              | Order Items          | order_id                 |
| Products   | product_id            | Order Items          | product_id               |
| Products   | product_category_name | Category Translation | product_category_name    |
| Date Table | Date                  | Orders               | order_purchase_timestamp |

---

# Note

This data model follows a star schema approach, where:

* Fact Table: Orders
* Dimension Tables: Customers, Order Items, Products, Product Category Translation, Date Table

---

