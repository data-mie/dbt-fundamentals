with customers as (
  select 
    *
  from {{ ref('customers') }}
),

orders as (
    select
        *
    from {{ ref('orders') }}
)

select distinct
        customers.customer_id,
        count(*) over (partition by customers.customer_id) as order_count,
        avg(total_amount) over (partition by customers.customer_id) as avg_order_amount
from orders
inner join customers on orders.customer_id = customers.customer_id
where ordered_at > current_date - 180

