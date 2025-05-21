with source as (
    select *
    from {{ source('ecomm', 'customers') }}
),

renamed as (
    select
    id as customer_id,
    *
    from source
)

select *
from renamed