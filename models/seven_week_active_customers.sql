with recent_orders as (
    select * 
    from {{ ref('recent_orders') }}
),

order_stats as (
    select * 
    from {{ ref('order_stats') }}
)

select 
    cust.customer_id,
    cust.first_name,
    cust.last_name,
    os.avg_order_amount,
    os.order_count    
from {{ ref('customers') }} as cust
left join order_stats os on cust.customer_id = os.customer_id   
inner join recent_orders ro on cust.customer_id = ro.customer_id