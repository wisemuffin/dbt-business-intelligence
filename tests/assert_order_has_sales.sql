-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail
select
    order_key,
    sum(sales) as total_sales
from {{ ref('fact_sales' )}}
group by 1
having not(total_sales >= 0)
