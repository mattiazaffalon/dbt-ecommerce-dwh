{% snapshot customers_snapshot %}

    --  parameterize target_schema below

{{
    config(
      unique_key='customer_cd',
      target_schema='dbt_ecommerce',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}


with 

src as (
    SELECT * FROM {{ source('dbt_ecommerce', 'raw_customers') }} e
),

cur as (
    SELECT r.*,
        row_number() over (partition by customer_cd order by updated_at desc) as ord
    FROM src r
    QUALIFY ord = 1
)

select * from cur

{% endsnapshot %}