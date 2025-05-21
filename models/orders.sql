with
    orders as (select * from {{ ref("stg_ecomm__orders") }}),

    deliveries as (select * from {{ ref("stg_ecomm__deliveries") }}),

    deliveries_filtered as (select * from deliveries where status = 'delivered'),

    joined as (
        select
            o.order_id,
            o.customer_id,
            o.ordered_at,
            o.order_status,
            o.total_amount,
            o.store_id,
            datediff(
                'minutes', o.ordered_at, d.delivered_at
            ) as delivery_time_from_order,
            datediff(
                'minutes', d.picked_up_at, d.delivered_at
            ) as delivery_time_from_collection

        from orders as o
        left join deliveries_filtered as d on (o.order_id = d.order_id)
    )

select *
from joined
