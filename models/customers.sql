with orders as (
    select
        *
    from {{ ref('orders') }}
), 

customers as (
    select
        id as customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from {{ ref('stg_ecomm__customers') }}
),

survey_responses as (
    select
        *
    from {{ ref('stg_sheets__customer_survey_responses') }}
),

{% set days_list = [30, 90, 360] %}

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(delivery_time_from_order) as average_delivery_time_from_order,
        avg(delivery_time_from_collection) as average_delivery_time_from_collection
        {% for day in days_list %}
            ,count_if(datediff(day, current_date(), orders.ordered_at) < {{day}} ) as count_orders_last_{{day}}_days
        {% endfor %}
    from orders
    group by 1

),

joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        customer_metrics.average_delivery_time_from_order,
        customer_metrics.average_delivery_time_from_collection
        {% for day in days_list %}
            , customer_metrics.count_orders_last_{{day}}_days
        {% endfor %}
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
    left join survey_responses on (
        customers.email = survey_responses.customer_email
    )
)

select
    *
from joined