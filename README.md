# dbt-ecommerce-dwh

## Dimensional model
fact_orders:
 - order_id (PK)
 - order_num
 - time_id
 - customer_id
 - product_id
 - unit_price
 - quantity
 - discount
 - total_amount

dim_customer:
 - customer_id (PK)
 - customer_cd
 - surname
 - name
 - address
 - city
 - region
 - country
 - postal_code
 - email

dim_product:
 - product_id (PK)
 - product_cd
 - name
 - description
 - category
 - price

dim_time:
 - time_id (PK)
 - year
 - month
 - day
 - hour
 - minute
 - second
