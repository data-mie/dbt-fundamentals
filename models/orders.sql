with
    orders as (
        -- Select everything from stg_ecomm__orders
        select * from {{ ref("stg_ecomm__orders") }}),

    deliveries as (
        -- Select everything from stg_ecomm__deliveries
        select * from {{ ref("stg_ecomm__deliveries") }}),

    deliveries_filtered as (
          -- Select everything from deliveries
  -- Include only deliveries with the 'delivered' status
        select * from deliveries where status = 'delivered'),

    joined as (
        -- Select order_id, customer_id, ordered_at, order_status, total_amount and store_id from orders
        -- Calculate delivery_time_from_order as datediff (in minutes) between ordered_at (orders) and delivered_at (deliveries_filtered)
        -- Calculate delivery_time_from_collection as datediff (in minutes) between picked_up_at (deliveries_filtered) and delivered_at (deliveries_filtered)
        -- Do a left join between orders and deliveries_filtered using order_id
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
