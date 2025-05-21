{% macro parse_date(date) %}
    -- Parse dates
    coalesce(
    try_to_date({{date}}, 'MM/DD/YY'),
    try_to_date({{date}}, 'MM/DD/YYYY'),
    try_to_date({{date}}, 'YYYY-MM-DD')
    )
{% endmacro %}