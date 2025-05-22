with customers as (
    select * 
    from {{ ref('customers') }}
),

distinct_customers as (
    select *
    from {{ ref('int_marketing__seven_week_active_customers') }}
),

order_metrics as (
    select *
    from {{ ref('int_marketing__customer_order_stats') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    order_metrics.avg_order_amount,
    order_metrics.order_count
from customers
left join order_metrics using (customer_id)
inner join distinct_customers using (customer_id)
