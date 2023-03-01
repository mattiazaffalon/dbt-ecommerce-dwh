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



(sudo docker stop dbt || exit 0) && \
(sudo docker rm dbt || exit 0) \
sudo docker run -t -d --name dbt dbt-ecommerce-dwh:latest

sudo docker exec -it dbt /bin/bash

## Static solution diagram:
![Diagram](https://github.com/mattiazaffalon/dbt-ecommerce-dwh/blob/docs/Solution%20diagram.drawio)

## How to prepare your virtual environment to make sure you are working with python >= 3.8

(Make sure you have python3.8 intalled on your system)
```bash
python3.8 -m venv .venv

source .venv/bin/activate

pip install --upgrade pip

pip install --upgrade setuptools
pip install --upgrade wheel

```

## Install dbt and other dependencies (see requirements.txt)
```bash
pip install -r requirements.txt
```

## Make dbt install its own deps (see file packages.yml)
```
dbt deps
```

## Create external tables
```bash
dbt run-operation stage_external_sources
```

## Command to put in container
```bash
dbt run-operation stage_external_sources && \
    dbt snapshot && \
    dbt run \
    dbt test
```