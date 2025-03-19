select distinct
    customer_id
from {{ ref('orders') }}
where ordered_at > current_date - 49  -- Include orders from last 7 weeks