with source as ( 
  select
    *
  from {{source("ecomm", "customers")}}
),

final as (  
  select
    id as customer_id, 
    *
  from source
)

select
  *
from final