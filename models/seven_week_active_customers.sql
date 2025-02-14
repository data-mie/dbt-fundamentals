-- select
--     customer_id,
--     first_name,
--     last_name,
--     (select round(avg(total_amount),2) from {{ ref('orders') }} where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as avg_order_amount,
--     (select count(*) from {{ ref('orders') }} where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as order_count
-- from {{ ref('customers') }}
-- where customer_id in (
--   select
--     distinct customer_id
--   from {{ ref('orders') }}
--   where ordered_at > current_date - 49
-- )

-- refactoring

with customers as (
    select *
    from {{ ref('customers') }}
),

recent_orders as (
    select distinct customer_id
    from {{ ref('orders') }}
    where ordered_at > current_date - 49
),

order_stats as (
    select *
    from {{ ref('orders_stats') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    order_stats.avg_order_amount,
    order_stats.order_count
from customers
left join order_stats on (customers.customer_id = order_stats.customer_id)
inner join recent_orders on (customers.customer_id = recent_orders.customer_id)
