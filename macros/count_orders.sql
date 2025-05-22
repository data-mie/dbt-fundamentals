{% macro count_orders(days) %}
    {%- for item in days %}
        count(case when ordered_at > current_date() - interval '{{ item }} day' then 1 end) as count_orders_last_{{ item }}_days
        {%- if not loop.last %}, {% endif %}
    {%- endfor %}
{% endmacro %}
