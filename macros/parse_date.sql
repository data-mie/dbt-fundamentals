{%- macro parse_date(date_column) -%}
    coalesce(
        try_to_date({{date_column}}, 'MM/DD/YY'),
        try_to_date({{date_column}}, 'MM/DD/YYYY'),
        try_to_date({{date_column}}, 'YYYY-MM-DD'))
{%- endmacro -%}