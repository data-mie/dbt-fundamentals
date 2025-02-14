-- Select all columns from the staging model
-- Note that no rename is needed here as the renaming was done in the staging model
with
orders as (select * from {{ ref("orders") }}),

customers as (select * from {{ ref("stg_ecomm__customers") }}),

-- Add the survey_responses CTE
survey_responses as (
    select * from {{ ref("stg_sheets__customer_survey_responses") }}
),

customer_metrics as (
    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(delivery_time_from_collection)
            as average_delivery_time_from_collection,
        avg(delivery_time_from_order) as average_delivery_time_from_order,
        {% for days in [30, 90, 360] %}
            count(
                case when ordered_at > current_date - {{ days }} then 1 end
            ) as count_orders_last_{{ days }}_days
            {% if not loop.last %},{% endif %}
        {% endfor %}
    from orders
    group by 1

),

joined as (
    select
        customers.*,
        -- Add the satisfaction_score column
        survey_responses.satisfaction_score,
        survey_responses.survey_date,  -- Add the survey_date column
        coalesce(customer_metrics.count_orders, 0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at,
        customer_metrics.average_delivery_time_from_collection,
        customer_metrics.average_delivery_time_from_order,
        {% for days in [30, 90, 360] %}
            customer_metrics.count_orders_last_{{ days }}_days
            {% if not loop.last %},{% endif %}
        {% endfor %}

    from customers
    left join
        customer_metrics
        on (customers.customer_id = customer_metrics.customer_id)
    left join
        survey_responses on (customers.email = survey_responses.customer_email)
),

final as (select * from joined)

select *
from final
