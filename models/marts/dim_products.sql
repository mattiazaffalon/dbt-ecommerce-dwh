{{ config(materialized='view') }}

select 
    dbt_scd_id as product_id,
    product_cd,
    name,
    description,
    category,
    unit_price,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to
from {{ ref('products_snapshot') }}