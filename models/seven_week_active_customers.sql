with

    customers as (
        select * from {{ ref('customers') }}
    ),

    orders as (
        select * from {{ ref("orders") }}
    ),

    order_count_and_avg as (
        select *
        from {{ ref("last_6m_order_count_and_avg") }}
        
    ),

    customer_id_from_last_50_days_order as (
        select *
        from {{ ref("last_7w_active_customer_ids") }}
    )


select
    customer_id,
    first_name,
    last_name,
    avg_order_amount,
    order_count
from customers
left join order_count_and_avg using (customer_id)
join customer_id_from_last_50_days_order using (customer_id)
