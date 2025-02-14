select
        id as order_id,
        total_amount,
        status as order_status,
        created_at as ordered_at,
        customer_id,
        store_id
    from {{source('ecomm', 'orders')}}