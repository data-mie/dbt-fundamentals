
{% macro parse_date(column_name) %}

coalesce(
  try_to_date({{ column_name }}, 'MM/DD/YY'),
  try_to_date({{ column_name }}, 'MM/DD/YYYY'),
  try_to_date({{ column_name }}, 'YYYY-MM-DD')
)

{% endmacro %}