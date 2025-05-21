with source as (  
  select
    *
  from {{ source('ecomm', 'orders') }} 
),

renamed as (  -- Rename columns as needed
  select
    id as order_id,  -- Have primary key as the first column
    *,
    created_at as ordered_at,
    status as order_status
  from source
),

final as (    -- Final transformations go here
  select
    *
  from renamed
)

select
  *
from final    -- When debugging your code, you can change this to refer to any of the CTEs above