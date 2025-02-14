select
        id as customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from {{source('ecomm', 'customers')}}