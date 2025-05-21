select 
    id as order_id,
    created_at as ordered_at,
    status as ordered_status,
    *

from  {{ source('ecomm', 'orders') }}

