{{
  config(
    post_hook='{{ postgres_create_index(this, "customer_key") }}'
  )
}}

select
    {{ dbt_utils.surrogate_key(['customer_code']) }} customer_key,
    *
from {{ ref('stg_customer') }}