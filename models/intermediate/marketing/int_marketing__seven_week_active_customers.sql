with seven_weeks_customer_orders as (
        select distinct customer_id
        from {{ ref("orders") }}
        where ordered_at > current_date - 49
)

select * from seven_weeks_customer_orders