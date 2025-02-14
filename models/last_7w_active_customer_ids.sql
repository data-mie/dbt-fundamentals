{{ config( materialized='ephemeral' ) }}


select distinct customer_id
from orders
where ordered_at > current_date - 49