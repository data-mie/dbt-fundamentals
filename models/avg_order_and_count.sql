{{ config(materialized='ephemeral') }}
with orders_avg_amount as (
    select customer_id,
    round(avg(total_amount),2) as avg_order_amount,
    count(*) as order_count
    from {{ ref('orders') }}
    where ordered_at > current_date - 180
    group by 1
    order by customer_id
)


select * from orders_avg_amount