with customers as (
    select
        sum(count_orders_last_90_days) as customers_count
    from {{ ref('customers') }}
),

orders as (
    select
        count(*) as orders_count
    from {{ ref('orders') }}
),

joined as (
    select
        *
    from customers
    cross join orders
    where customers_count > orders_count
)

select
    *
from joined