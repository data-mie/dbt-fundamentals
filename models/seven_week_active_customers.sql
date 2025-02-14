with customers as (
  select
    *
  from {{ ref('customers') }}
),

seven_weeks as (
  select *
  from {{ ref('_seven_weeks') }}
),

half_year as (
    select *
    from {{ ref('_six_months_customer_metrics') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    half_year.avg_order_amount,
    half_year.order_count
from customers
left join half_year on (customers.customer_id = half_year.customer_id)
inner join seven_weeks on (customers.customer_id = seven_weeks.customer_id)