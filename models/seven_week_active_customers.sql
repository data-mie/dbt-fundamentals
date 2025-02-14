with customer_id as (
    select * from {{ ref('customer_id') }}
),

orders_avg_amount as (
    select * from {{ ref('avg_order_and_count') }}
)


select * 
from customer_id
inner join orders_avg_amount using (customer_id)
