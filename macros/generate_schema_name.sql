{#
  Sobrescribe el comportamiento por defecto de dbt para que los esquemas se llamen
  exactamente STAGING, INTERMEDIATE y MARTS (en vez de DBT_DEV_STAGING, etc.).
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
