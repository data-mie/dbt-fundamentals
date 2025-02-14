-- Non - CTE query
/*
select
    customer_id,
    first_name,
    last_name,
    (
        select round(avg(total_amount), 2)
        from {{ ref("orders") }}
        where
            orders.customer_id = customers.customer_id
            and ordered_at > current_date - 180
    ) as avg_order_amount,
    (
        select count(*)
        from {{ ref("orders") }}
        where
            orders.customer_id = customers.customer_id
            and ordered_at > current_date - 180
    ) as order_count
from {{ ref("customers") }}
where
    customer_id in (
        select distinct customer_id
        from {{ ref("orders") }}
        where ordered_at > current_date - 49
    )
*/
-- CTE Query Refactore
with
    customers as (select * from {{ ref("customers") }}),

    seven_weeks as (
        select distinct customer_id
        from {{ ref("orders") }}
        where ordered_at > current_date - 49
    )

select
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    (
        select round(avg(total_amount), 2)
        from {{ ref("orders") }}
        where
            orders.customer_id = customers.customer_id
            and ordered_at > current_date - 180
    ) as avg_order_amount,
    (
        select count(*)
        from {{ ref("orders") }}
        where
            orders.customer_id = customers.customer_id
            and ordered_at > current_date - 180
    ) as order_count
from customers
inner join seven_weeks on (customers.customer_id = seven_weeks.customer_id)

-- Another Section
with
    customers as (select * from {{ ref("customers") }}),

    seven_weeks as (
        select distinct customer_id
        from {{ ref("orders") }}
        where ordered_at > current_date - 49
    ),

    half_year as (
        select
            customer_id,
            round(avg(total_amount), 2) as avg_order_amount,
            count(*) as order_count
        from {{ ref("orders") }}
        where ordered_at > current_date - 180
        group by 1
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
