with orders as (
  select * from {{ ref('stg_ecomm__orders') }}
),

deliveries as (
  select * from {{ ref('stg_ecomm__deliveries') }}
),

deliveries_filtered as (
  select * from deliveries
  where delivery_status = 'delivered'
),

joined as (
    select
    o.order_id,
    customer_id,
    ordered_at,
    order_status,
    total_amount,
    store_id,
    datediff("minutes", o.ordered_at, df.delivered_at) as delivery_time_from_order,
    datediff("minutes", df.picked_up_at, df.delivered_at) as delivery_time_from_collection
    from orders o
    left join deliveries_filtered df on o.order_id = df.order_id
)

select
  *
from joined