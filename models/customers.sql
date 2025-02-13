with orders as (
    select
        *
    --from {{ ref('stg_ecomm__orders') }}
    from {{ ref('orders') }}
), 

customers as (
    select
        id as customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from raw.ecomm.customers
),

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(delivery_time_from_collection) as average_delivery_time_from_collection,
        avg(delivery_time_from_order) as average_delivery_time_from_order
    from orders
    group by 1

),

joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        average_delivery_time_from_collection,
        average_delivery_time_from_order
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
)

select
    *
from joined