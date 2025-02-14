{% macro parse_date(column) %}

--Parse dates
coalesce(
    try_to_date({{ column }},'MM/DD/YY'),
    try_to_date({{ column }},'YYYY-MM-DD'),
    try_to_date({{ column }},'MM/DD/YYYY')

)

{% endmacro %}
