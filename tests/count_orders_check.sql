with
    orders as (select count(*) as orders_count from {{ ref("orders") }}),

    customers as (
        select sum(count_orders_last_90_days) as customers_count
        from {{ ref("customers") }}
    ),

    joined as (
        select *
        from orders
        cross join customers  -- Do you know how a cross join works? If not, look it up!
        -- Alternative way to write the cross join:
        -- inner join customers on 1=1
        where customers_count > orders_count
    )

select *
from joined
