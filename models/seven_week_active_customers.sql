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

with customer as (
    select
        customer_id,
        first_name,
        last_name
    from {{ref('customers')}}
),

orders_last_six_months as (
    select
        *
    from {{ref('orders_last_six_months')}}
),

customers_with_orders_last_7_weeks as (
    select
        *
    from {{ref('customers_with_orders_last_seven_weeks')}}
),

joined as (
    select
        customer.customer_id,
        customer.first_name,
        customer.last_name,
        orders_last_six_months.avg_order_amount,
        orders_last_six_months.order_count
    from customer
    inner join customers_with_orders_last_7_weeks
        on customer.customer_id = customers_with_orders_last_7_weeks.customer_id
    left join orders_last_six_months
        on customer.customer_id = orders_last_six_months.customer_id
)

select
    * 
from joined