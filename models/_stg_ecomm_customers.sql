with customers as (
    select *,
        id as customer_id
    from  {{ source("ecomm", "customers") }}
)

select * from customers