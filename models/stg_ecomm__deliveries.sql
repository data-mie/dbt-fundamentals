with source as (  -- This is where you select data from your source table
  select
    *
  from {{ source('ecomm', 'deliveries') }}
),

renamed as (  -- Rename columns as needed
  select
    id as delivery_id,  -- Have primary key as the first column
    *,
    status as delivery_status
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