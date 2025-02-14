{{
    config(
        materialized='table',
        cluster_by=['rating']
    )
}}

with source as (
    select 
    * 
    from {{ source('movies', 'ratings') }}
),

renamed as (
    select
        user_id,
        movie_id,
        rating,
        timestamp
    from source
    where movie_id=1210
)

select 
* 
from renamed
