with source as ( 
  select
    *
  from {{source("ecomm", "deliveries")}}
),

final as (  
  select
    id as delivery_id, 
    status as delivery_status,
    *
  from source
)

select
  *
from final