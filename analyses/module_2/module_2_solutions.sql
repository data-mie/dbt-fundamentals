-- Jinja 1/2
{% for type in ['tax','product','shipping','adjustment'] %}
    sum(case when type = '{{ type }}' then amount end) as {{ type }}_amount {{- ',' if not loop.last }}
{%- endfor %}


-- Jinja 2/2
-- statement
{% if true %} {% endif %}

-- expression
{{ 'hello world' }}

-- comment
{# Explain my Jinja code #}


-- Macro
{% set types = ['tax','product','shipping','adjustment'] %}

select
    {{ solution_sum_amount_by_type(types) }}
