{{ config(materialized='table') }}

select * 
from {{ source('movies', 'ratings') }}