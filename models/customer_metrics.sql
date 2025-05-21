select
customer_id,
count_orders
from {{ref("customers")}}