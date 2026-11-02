
---Normaliza una columna de texto: quita espacios al principio y al final (trim)y unifica mayúsculas/minúsculas según text_case:

{% macro clean_text(column, text_case='none') %}
    {%- if text_case == 'upper' -%}
        upper(trim({{ column }}))
    {%- elif text_case == 'lower' -%}
        lower(trim({{ column }}))
    {%- elif text_case == 'title' -%}
        initcap(trim({{ column }}))
    {%- else -%}
        trim({{ column }})
{%- endif -%}
{% endmacro %}