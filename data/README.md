# Sample data generator

## Data model for input files
billing_orders_yyyyMMdd.csv:
 - order_num
 - datetime (yyyyMMdd hh:mm:ss)
 - customer_cd
 - product_cd 
 - unit_price 
 - quantity
 - discount
 - total_amount

customer_d_yyyyMMdd.csv:
 - customer_cd
 - surname
 - name
 - address
 - city
 - region
 - country
 - postal_code
 - email

products_catalog_f_yyyyMMdd.csv:
 - product_cd
 - name
 - description
 - category
 - unit_price


## Generating seed sample files
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python data_generator.py
```

## Copy to Google cloud storage
(optional)
```bash
gsutil -m rm -r gs://dbt-ecommerce-raw/*
```

```bash
gsutil cp ./generated/billing_orders_d_*.csv gs://dbt-ecommerce-raw/billing_orders/
gsutil cp ./generated/customers_d_*.csv gs://dbt-ecommerce-raw/customers/
gsutil cp ./generated/products_f_*.csv gs://dbt-ecommerce-raw/products/

```

(optional) see contents

```bash
gsutil ls gs://dbt-ecommerce-raw/**/*
```