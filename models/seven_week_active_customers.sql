with
customers as (select * from {{ ref("customers") }}),

seven_week_customers as (select * from {{ ref("_7_week_active_customers") }}),

customer_metrics as (select * from {{ ref("_6_month_customer_order_metrics") }}
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_metrics.avg_order_amount,
        customer_metrics.order_count
    from customers
    left join
        customer_metrics
        on (customers.customer_id = customer_metrics.customer_id)
    inner join
        seven_week_customers
        on (customers.customer_id = seven_week_customers.customer_id)
)

select *
from final
