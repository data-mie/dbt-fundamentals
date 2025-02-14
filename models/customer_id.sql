{{ config(materialized='ephemeral') }}

with customer_id as (
    select customer_id,
    first_name,
    last_name

      from {{ ref('customers') }}
      inner join {{ ref('orders') }} using(customer_id)
  where ordered_at > current_date - 49
)

select * from customer_id