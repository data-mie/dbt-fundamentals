with orders as (
    select
        *
    from {{ref("orders")}}
), 

customers as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from {{ref("stg_ecomm__customers")}}
),

survey as (
    select 
    {{parse_date("survey_date")}} as survey_date_1,
        * 
    from {{ref("stg_sheets__survey")}}
),

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,

        {% for days in [30, 90, 360] %}
            count(CASE WHEN datediff('days', ordered_at, current_date()) <= {{days}} then 1 end ) as count_orders_last_{{days}}_days,
        {% endfor %}

        avg(delivery_time_from_order) as delivery_time_from_order,
        avg(delivery_time_from_collection) as delivery_time_from_collection
    from orders
    group by customer_id

),

joined as (
    select
        survey.survey_date_1,
        survey.satisfaction_score ,
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        customer_metrics.delivery_time_from_order,
        customer_metrics.delivery_time_from_collection,
        customer_metrics.count_orders_last_30_days,
        customer_metrics.count_orders_last_90_days,
        customer_metrics.count_orders_last_360_days
    from customers
    left join customer_metrics on (
        customers.customer_id = customer_metrics.customer_id
    )
    left join survey on(
        customers.email = survey.customer_email
    )
)

select
    *
from joined