{{ config( materialized='table', cluster_by=['movie_id'] ) }}


with ratings as (
    select * from {{source("movies", "ratings")}}
)


select * from ratings
