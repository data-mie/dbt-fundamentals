with orders as (
    select
        *
    from {{ref("stg_ecomm__orders")}}
), 

deliveries as (
    select
        *
    from {{ref("stg_ecomm__deliveries")}}
    where delivery_status='delivered'
),


joined as (
    select
        orders.order_id,
        orders.customer_id,
        orders.ordered_at,
        orders.order_status,
        orders.total_amount,
        orders.store_id,
        datediff('minutes', orders.ordered_at, deliveries.delivered_at) as delivery_time_from_order,
        datediff('minutes', deliveries.picked_up_at, deliveries.delivered_at) as delivery_time_from_collection
    from orders
    left join deliveries on (
        orders.order_id = deliveries.order_id
    )
)

select
    *
from joined