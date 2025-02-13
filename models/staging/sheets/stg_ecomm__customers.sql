with source as (
    select 
        * 
    from {{ source('sheets', 'customers') }}
),

renamed as (
    select
        id as customer_id,
        *       
    from source
),

final as (
    select
        *
    from renamed
)

select 
    * 
from final
