{% macro count_orders_in_last_days(days) %}
{% for day in days %}
count(case when ordered_at > current_date - {{ day }} then 1 end) as count_orders_last_{{ day }}_days{% if not loop.last %},{% endif %}
{% endfor %}
{% endmacro %}