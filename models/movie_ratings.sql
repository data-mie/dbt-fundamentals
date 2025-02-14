with source as(
    select *
    from {{ ref('stg_movies__ratings') }}
),

filtered as(
    select *
    from source
    where movie_id=1210
)

select *
from filtered