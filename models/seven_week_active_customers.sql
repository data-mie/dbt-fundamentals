/*
select
    customer_id,
    first_name,
    last_name,
    (select round(avg(total_amount),2) from {{ ref('orders') }} where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as avg_order_amount,
    (select count(*) from {{ ref('orders') }} where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as order_count
from {{ ref('customers') }}
where customer_id in (
  select
    distinct customer_id
  from {{ ref('orders') }}
  where ordered_at > current_date - 49
)*/
with customers as (
    select
        *
    from {{ ref('customers') }}
),

seven_week_customers as (
    select
        *
    from {{ ref('_7_week_active_customers') }}
), 

customer_metrics as (
    select 
        *
    from {{ ref('_6_month_customer_order_metrics') }}
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_metrics.avg_order_amount,
        customer_metrics.order_count
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
    inner join seven_week_customers on (
        customers.customer_id = seven_week_customers.customer_id
    )
)

select 
    *
from final