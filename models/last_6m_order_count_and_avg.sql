{{ config( materialized='ephemeral' ) }}


select count(*) as order_count, round(avg(total_amount), 2) as avg_order_amount, customer_id
from orders
where ordered_at > current_date - 180
group by customer_id
