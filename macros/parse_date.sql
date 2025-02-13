{% macro parse_date(dates) %}

    coalesce(
    try_to_date({{ dates }}, 'MM/DD/YY'),
    try_to_date({{ dates }}, 'MM/DD/YYYY'),
    try_to_date({{ dates }}, 'YYYY-MM-DD')
)
    
{% endmacro %}