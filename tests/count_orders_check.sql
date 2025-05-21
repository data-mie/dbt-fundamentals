with 
orders as (select count(*) as ord_cnt from {{ ref('orders') }}),

customers as (select sum(count_orders_last_90_days) as cust_cnt from {{ ref('customers') }} ),

test_case as (
                select
                1
                from 
                orders, customers
                where customers.cust_cnt > orders.ord_cnt
)

select * from test_case
