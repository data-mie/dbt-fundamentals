select * 

from {{ref('customers')}}
where count_orders < count_orders_last_90_days