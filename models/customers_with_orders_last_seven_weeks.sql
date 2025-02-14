{{ config(materialized='ephemeral')}}

with orders as (
    select
        *
    from {{ref('orders')}}
),

customers_with_orders_last_seven_weeks as (
    select
        distinct(customer_id) as customer_id,
    from orders
    where ordered_at > current_date - 49
)

select
    *
from customers_with_orders_last_seven_weeks