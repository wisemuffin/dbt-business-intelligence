{{
  config(
    indexes=[
      {'columns': ['customer_key', 'order_key', 'product_key', 'date_key'], 'unique': True},
    ]
  )
}}

with sales_data as (

    select * from {{ ref('stg_sales_data') }}

),

final as (

    select
        {{ dbt_utils.surrogate_key(['customer_code']) }} customer_key,
        {{ dbt_utils.surrogate_key(['order_number','order_line_number']) }} order_key,
        {{ dbt_utils.surrogate_key(['product_code']) }} product_key,
        {{ dbt_utils.surrogate_key(['order_date']) }} date_key,
        sales_data.order_date date_day,
        sales_data.quantity,
        sales_data.price,
        sales_data.sales,
        sales_data.target
    from sales_data

)

select * from final