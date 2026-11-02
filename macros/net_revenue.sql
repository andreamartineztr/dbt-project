{#
  MACRO: net_revenue
  Calcula el ingreso neto de una línea de pedido:
      extended_price * (1 - discount) * (1 + tax)
  - tax es opcional (por defecto 0 => ingreso neto sin impuestos)
  - Redondea a 2 decimales.
  Se reutiliza en int_order_lines (con y sin impuestos) para tener UNA sola
  definición de negocio del ingreso.
#}
{% macro net_revenue(extended_price, discount, tax=0) %}
    round({{ extended_price }} * (1 - {{ discount }}) * (1 + {{ tax }}), 2)
{% endmacro %}
