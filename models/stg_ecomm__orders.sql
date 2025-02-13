with stg_ecomm__orders as 
(
    select id as order_id,
           total_amount,
           status as order_status,
           created_at as ordered_at,
           customer_id,
           store_id,
           _synced_at 
    from  {{source('ecomm' ,'orders')}}
    -- raw.ecomm.orders_us
)
   select * from stg_ecomm__orders 