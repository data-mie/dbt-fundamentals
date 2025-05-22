{{
    config(
        materialized='table'
    )
}}

with customers_metrics as (
    select *
    from {{ ref('int_marketing__customer_order_stats') }}
),

customers as (
    select 
        customer_id,
        first_name,
        last_name
    from {{ ref('customers') }}
),

recent_customers as (
    select *
    from {{ ref('int_marketing__seven_week_active_customers') }}
)

select
    recent_customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers_metrics.avg_order_amount,
    customers_metrics.order_count
from {{ ref('customers') }}
left join customers_metrics using (customer_id)
inner join recent_customers using (customer_id)