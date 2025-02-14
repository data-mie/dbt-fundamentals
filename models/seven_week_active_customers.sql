with customers as (  -- This is where you select data from your source table
    select
        *
    from {{ ref('customers') }}
),

distinct_order as (
    select
        *
    from {{ ref('seven_week_customers') }}
),

order_calculation as (
    select 
        *
    from {{ ref('six_month_metric_orders') }}
),

joined as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        order_calculation.rounded_order,
        order_calculation.counted_order
    from customers
    inner join distinct_order on distinct_order.customer_id = customers.customer_id
    inner join order_calculation on order_calculation.customer_id = customers.customer_id
),

final as (    -- This is here to make it easier to add additional transformations later
  select
    *
  from joined
)

select
  *
from final    -- When debugging your code, you can change this to refer to any of the CTEs above