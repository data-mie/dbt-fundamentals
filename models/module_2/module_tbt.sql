select
    'order_1' as order_id, -- primary key
    'customer_a' as customer_id,
    'product_red' as product,
    2 as quantity,
    100 as price,
    200 as total

union all

select
    'order_2' as order_id,
    'customer_a' as customer_id,
    'product_blue' as product,
    3 as quantity,
    50 as price,
    160 as total -- wrong total
