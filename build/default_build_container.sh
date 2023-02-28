#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/build_container.sh \
    /home/mattiapriv/.dbt/dbt-bank-transactions-dev-ecomm.json \
    dbt-bank-transactions-dev \
    dbt_ecommerce europe-west6