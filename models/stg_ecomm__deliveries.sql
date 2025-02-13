with stg_ecomm__deliveries as
(
  select id as delivery_id, order_id,picked_up_at,delivered_at,status as delivery_status,_synced_at  from  raw.ecomm.deliveries 
)
select * from stg_ecomm__deliveries
