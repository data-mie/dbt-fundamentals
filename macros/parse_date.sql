{% macro parse_date(args) %}  
    coalesce(
        try_to_date(survey_date, 'MM/DD/YY'),
        try_to_date(survey_date, 'MM/DD/YYYY'),
        try_to_date(survey_date, 'YYYY-MM-DD')
    )
{% endmacro %}