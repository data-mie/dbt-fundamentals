-- Refactors
{{ config(materialized="table") }}

with
customer_metrics as (
    select * from {{ ref("int_marketing__customer_order_stats") }}

),

recent_customers as (
    select * from {{ ref("int_marketing__seven_week_active_customers") }}
)

select
    customer_id,
    first_name,
    last_name,
    customer_metrics.avg_order_amount,
    customer_metrics.order_count
from {{ ref("customers") }}
left join customer_metrics using (customer_id)
inner join recent_customers using (customer_id)
