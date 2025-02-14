{{ config(materialized='ephemeral') }}

with orders as (
    select * from {{ ref('orders') }}
),

sixth_month as (
    select
        customer_id,
        round(avg(total_amount), 2) as avg_order_amount,
        count(*) as orders_count
    from orders
    where ordered_at > current_date - 180
    group by 1
)

select * from sixth_month