{{ config(materialized='table') }}

with source as (
    select
        *
    from {{ source('movies', 'ratings') }}
),

renamed as (
    select
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