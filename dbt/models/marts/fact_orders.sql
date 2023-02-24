{{
    config(
        materialized='incremental',
        unique_key='order_num'
    )
}}

with 

raw as (
    select * from {{ source('dbt_ecommerce', 'raw_billing_orders') }}
),

customers as (
    select * from {{ ref('dim_customers') }}
),

products as (
    select * from {{ ref('dim_products') }}
)

SELECT 
    order_num,
    created_at,
    customer_id,
    product_id,
    r.unit_price,
    quantity,
    discount,
    total_amount
FROM
    raw r inner join customers c on (r.customer_cd = c.customer_cd and {{ validate_dttm_interval('r.created_at', 'c.valid_from', 'c.valid_to') }})
    inner join products p on (r.product_cd = p.product_cd and {{ validate_dttm_interval('r.created_at', 'p.valid_from', 'p.valid_to') }})


{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where created_at >= (select max(created_at) from {{ this }})

{% endif %}