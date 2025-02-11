{% for type in ['tax','product','shipping','adjustment'] %}
    sum(case when type = '{{ type }}' then amount end) as {{ type }}_amount {{- ',' if not loop.last }}
{%- endfor %}
