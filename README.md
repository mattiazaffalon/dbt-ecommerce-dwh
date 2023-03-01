# dbt-ecommerce-dwh

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
![Static solution diagram](docs/Solution%20diagram.drawio.png "a title")

## Development

### Local environment setup (on Ubuntu)

**Prerequisite** Make sure you have python3.8 intalled on your system

In a command shell, execute the following command in the root directory of the project:
```bash
python3.8 -m venv .venv

source .venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt
```

Up to this point, dbt has been installed and is available as "dbt" from the command line.

### Instruct dbt to install its dependencies (see file packages.yml)
```
dbt deps
```

## Running and testing the transformations
```bash
dbt run-operation stage_external_sources && \
    dbt snapshot && \
    dbt run \
    dbt test
```