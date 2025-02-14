{{ config(materialized='view') }}
with 

source as (

    select * from {{ source('movies', 'ratings') }}

),

renamed as (

    select
        user_id,
        movie_id,
        rating,
        timestamp

    from source

)

select * from renamed
