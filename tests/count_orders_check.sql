with
    orders as (select count(*) as orders_count from {{ ref("orders") }}),

    customers_orders as (
        select sum(count_orders_last_90_days) as customers_orders_last_90_days_count
        from {{ ref("customers") }}
    ),

    joined as (
        select *
        from orders
        cross join customers_orders
        where customers_orders_last_90_days_count > orders_count
    )

select *
from joined
