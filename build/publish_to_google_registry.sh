#!/bin/bash

sudo docker tag dbt-ecommerce-dwh gcr.io/dbt-bank-transactions-dev/dbt-ecommerce-dwh
sudo docker push gcr.io/dbt-bank-transactions-dev/dbt-ecommerce-dwh