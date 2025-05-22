with orders as (
    select *
    from {{ ref('orders') }}
), 

customers as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from {{ ref('stg_ecomm__customers')}}
),

customer_survey as (
    select *
    from {{ ref('stg_sheets__customer_survey_responses') }}
),

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(delivery_time_from_collection) as average_delivery_time_from_collection,
        avg(delivery_time_from_order) as average_delivery_time_from_order,
        {{ count_orders([30, 90, 360]) }}
    from orders
    group by 1
),

joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        customer_metrics.count_orders_last_30_days,
        customer_metrics.count_orders_last_90_days,
        customer_metrics.count_orders_last_360_days,
        customer_survey.satisfaction_score,
        customer_survey.survey_date

    from customers

    left join customer_metrics on (customers.customer_id = customer_metrics.customer_id)
    left join customer_survey on (customers.email = customer_survey.customer_email)
)

select
    *
from joined