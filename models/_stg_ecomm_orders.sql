with orders as (
    select *,
        id as order_id,
        created_at as ordered_at,
        status as order_status
    from {{ source("ecomm", "orders") }}
)

select * from orders