{{ config(materialized='ephemeral') }}

with orders as (  -- This is where you select data from your source table
  select
    *
  from {{ ref('orders') }}
),

distinct_order as (
    select distinct 
        customer_id 
    from orders
    where ordered_at > current_date - 49
)

select
    * 
from 
    distinct_order