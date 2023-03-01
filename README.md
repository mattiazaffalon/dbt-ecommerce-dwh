# dbt-ecommerce-dwh

## Dimensional model
(sudo docker stop dbt || exit 0) && \
(sudo docker rm dbt || exit 0) \
sudo docker run -t -d --name dbt dbt-ecommerce-dwh:latest

sudo docker exec -it dbt /bin/bash

## DWH ER model
```mermaid
erDiagram
    fact_orders ||--|{ dim_customers: "from customer"
    fact_orders {
        string order_num
        datetime created_at
        string customer_id
        string product_id
        number unit_price
        int quantity
        number discount
        number total_amount
    }
    dim_customers {
        string customer_id
        string customer_cd
        string surname
        string name
        string address
        string city
        string region
        string country
        string email
        datetime valid_from
        datetime valid_to
    }
    fact_orders ||--|{ dim_products: "of product"
    dim_products {
        string product_id
        string product_cd
        string name
        string description
        string category
        number unit_price
        datetime valid_from
        datetime valid_to
    }
```

## Static solution diagram:
![Static solution diagram](./Solution%20diagram.drawio.png "a title")

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