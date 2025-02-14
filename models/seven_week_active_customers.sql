with customers as (
    select * from {{ ref('customers') }}
),

seven_weeks as (
    select * from  {{ ref('_7_week_active_customers') }}
),

half_year as (
    select * from  {{ ref('_6_month_customers') }}
)
select c.customer_id,
c.first_name,
c.last_name,
half_year.avg_order_amount,
half_year.orders_count

 from customers as c
 left join half_year on c.customer_id=half_year.customer_id
inner join seven_weeks 
on c.customer_id = seven_weeks.customer_id
