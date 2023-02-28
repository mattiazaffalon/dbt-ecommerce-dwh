{{ config(materialized='view') }}

select 
    dbt_scd_id as customer_id,
    customer_cd,
    surname,
    name,
    address,
    city,
    region,
    country,
    postal_code,
    email,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to
from {{ ref('customers_snapshot') }}