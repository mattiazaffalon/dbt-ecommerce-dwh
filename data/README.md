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


## Launch
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python data_generator.py
```