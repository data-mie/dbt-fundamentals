{% macro solution_sum_amount_by_type(types) -%}

{% for type in types %}
    sum(case when type = '{{ type }}' then amount end) as {{ type }}_amount {{- ',' if not loop.last }}
{%- endfor %}

{%- endmacro %}
