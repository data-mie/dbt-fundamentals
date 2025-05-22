-- models/intermediate/marketing/int_marketing__seven_week_active_customers.sql
select distinct
    customer_id
from {{ ref('orders') }}
where ordered_at > current_date - 49  -- Include orders from last 7 weeks