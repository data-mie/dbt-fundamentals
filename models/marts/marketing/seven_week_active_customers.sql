-- with customers as (
--   select *
--   from {{ ref('customers') }}
-- ),

-- seven_week_active_customers as (
--   select *
--   from {{ ref('int_marketing__seven_week_active_customers') }}
-- ),

-- customer_order_stats as (
--   select *
--   from {{ ref('int_marketing__customer_order_stats') }}
-- )

-- select
--     customers.customer_id,
--     customers.first_name,
--     customers.last_name,
--     customer_order_stats.avg_order_amount,
--     customer_order_stats.order_count
-- from customers
-- left join customer_order_stats on (
--     customers.customer_id = customer_order_stats.customer_id
-- )
-- inner join seven_week_active_customers on (
--     customers.customer_id = seven_week_active_customers.customer_id
-- )

with  __dbt__cte__int_marketing__seven_week_active_customers as (
select distinct
    customer_id
from analytics.dbt_stumelius.orders
where ordered_at > current_date - 49  -- Include orders from last 7 weeks
),  __dbt__cte__int_marketing__customer_order_stats as (
select
    customer_id,
    round(avg(total_amount),2) as avg_order_amount,
    count(*) as order_count
from analytics.dbt_stumelius.orders
where ordered_at > current_date - 180 -- Include orders from last 6 months
group by 1
), customers as (
  select *
  from analytics.dbt_stumelius.customers
),

seven_week_active_customers as (
  select *
  from __dbt__cte__int_marketing__seven_week_active_customers
),

customer_order_stats as (
  select *
  from __dbt__cte__int_marketing__customer_order_stats
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_order_stats.avg_order_amount,
    customer_order_stats.order_count
from customers
left join customer_order_stats on (
    customers.customer_id = customer_order_stats.customer_id
)
inner join seven_week_active_customers on (
    customers.customer_id = seven_week_active_customers.customer_id
)