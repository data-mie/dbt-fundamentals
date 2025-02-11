{% macro drop_old_relations(dryrun=False) %}

{% if execute %}
  {% set current_models=[] %}

  {% for node in graph.nodes.values()
     | selectattr("resource_type", "in", ["model", "seed", "snapshot"])%}
    {% do current_models.append(node.name) %}

  {% endfor %}
{% endif %}

{% set cleanup_query %}

      with models_to_drop as (
        select
          case 
            when table_type = 'BASE TABLE' then 'TABLE'
            when table_type = 'VIEW' then 'VIEW'
          end as relation_type,
          concat_ws('.', table_catalog, table_schema, table_name) as relation_name
        from 
          {{ target.database }}.information_schema.tables
        where table_schema = '{{ target.schema | upper }}'
          and table_name not in
            ({%- for model in current_models -%}
                '{{ model.upper() }}'
                {%- if not loop.last -%}
                    ,
                {% endif %}
            {%- endfor -%}))
      select 
        'drop ' || relation_type || ' ' || relation_name || ';' as drop_commands
      from 
        models_to_drop

  {% endset %}

{% do log(cleanup_query, info=True) %}
{% set drop_commands = run_query(cleanup_query).columns[0].values() %}

{% if drop_commands %}
  {% if dryrun | as_bool == False %}
    {% do log('Executing DROP commands...', True) %}
  {% else %}
    {% do log('Printing DROP commands...', True) %}
  {% endif %}
  {% for drop_command in drop_commands %}
    {% do log(drop_command, True) %}
    {% if dryrun | as_bool == False %}
      {% do run_query(drop_command) %}
    {% endif %}
  {% endfor %}
{% else %}
  {% do log('No relations to clean.', True) %}
{% endif %}

{%- endmacro -%}