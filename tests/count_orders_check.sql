with 
orders as (select count(*) as cnt from {{ ref('orders') }}),

test_case as (
                select
                1
                from 
                {{ ref('customers') }} as cust, orders

                where cust.count_orders_last_90_days > orders.cnt
)

select * from test_case
