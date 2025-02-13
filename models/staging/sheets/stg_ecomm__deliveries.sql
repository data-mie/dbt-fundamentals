with source as (
    select 
        * 
    from {{ source('sheets', 'deliveries') }}
),

renamed as (
    select
        id as delivery_id,
        *,
        status as delivery_status,
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
