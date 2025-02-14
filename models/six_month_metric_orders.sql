{{ config(materialized='ephemeral') }}

with orders as (  -- This is where you select data from your source table
  select
    *
  from {{ ref('orders') }}
),

order_calculation as (
    select 
        round(avg(total_amount),2) as rounded_order,
        count(*) as counted_order,
        customer_id
    from orders
    where ordered_at > current_date - 180
    group by customer_id
)

select
    * 
from order_calculation