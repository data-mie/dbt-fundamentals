with
    source as (select * from {{ source("ecomm", "orders") }}),

    rename as (
        select id as order_id,  *, created_at as ordered_at, status as order_status
        from source
    )

select *
from rename
