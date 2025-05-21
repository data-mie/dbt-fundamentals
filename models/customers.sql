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

customer_survey_responses as (
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
        avg(delivery_time_from_order) as delivery_time_from_order,
        {% for period in [30, 90, 360] %}
            count(case when datediff(day, ordered_at, getdate())<{{period}} then 1 end) as count_orders_last_{{ period }}_days
            {% if not loop.last %}
                ,
            {% endif %}
        {% endfor %}
    from orders
    group by customer_id
),



joined as (
    select
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        {% for period in [30, 90, 360] %}
            coalesce(count_orders_last_{{ period }}_days,0) as count_orders_last_{{ period }}_days,
        {% endfor %}
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        survey_date,
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
    left join customer_survey_responses on customers.email = customer_survey_responses.customer_email
)

select
    *
from joined