{{ config(materialized='ephemeral') }}

with recent_orders as (
    select distinct customer_id
    from {{ ref('orders') }}
    where ordered_at > current_date - 49
)

select * 
from recent_orders