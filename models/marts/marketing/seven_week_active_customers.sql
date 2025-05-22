with
orders as (
    select
        *
    from {{ ref('orders') }}
),

customers as (
    select
        *
    from {{ ref('customers') }}
),

transformation as (
select
    customers.customer_id,
    customers.first_name,
    customers.last_name
from customers
inner join {{ ref('int_orders_last_49_days') }} as int_orders_last_49_days
    on int_orders_last_49_days.customer_id = customers.customer_id
),

final_transformation as (
    select
        transformation.customer_id,
        transformation.first_name,
        transformation.last_name,
        round(int_orders_last_180_days.avg_order_amount,2) as avg_order_amount,
        int_orders_last_180_days.order_count
    from transformation
    inner join {{ ref('int_orders_last_180_days') }} as int_orders_last_180_days 
        on int_orders_last_180_days.customer_id = transformation.customer_id
    
)

select * from final_transformation
