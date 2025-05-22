with table_1 as (
    select 
        sum(count_orders_last_90_days) as sum_customers_orders_last_90_days_count
    from {{ ref('customers') }}
),

table_2 as (
    select
        count(distinct order_id) as order_count
    from {{ ref('orders') }}
),

joined as (
    select
        *
    from table_1
    join table_2 on 1 = 1
)

select *
from joined
where sum_customers_orders_last_90_days_count > order_count
