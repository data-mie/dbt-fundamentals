{{ config(materialized='table', cluster_by=['user_id'])}}

with source as (
    select * from {{ source('movies','ratings') }}
)
,

renamed as (
    select * from source
),

final as (select * from renamed)

select * from final