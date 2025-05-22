-- CTE
with
    customers as (select * from {{ ref("customers") }}),

    seven_weeks_customer_orders as (
        select * from {{ ref("int_marketing__seven_week_active_customers") }}
    ),

    orders_stats as (select * from {{ ref("int_marketing__customer_order_stats") }})

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    orders_stats.avg_order_amount,
    orders_stats.order_count
from customers
left join orders_stats on (customers.customer_id = orders_stats.customer_id)
inner join
    seven_weeks_customer_orders
    on (customers.customer_id = seven_weeks_customer_orders.customer_id)
order by 1 asc
