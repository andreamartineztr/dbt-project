{# TABLA DE HECHOS. Granularidad: una fila por línea de pedido (order_key + line_number). #}

select
    {{ dbt_utils.generate_surrogate_key(['order_key', 'line_number']) }}  as order_line_key,

    -- claves a dimensiones
    customer_key,
    part_key,
    supplier_key,
    to_number(to_char(order_date, 'YYYYMMDD'))   as order_date_key,
    to_number(to_char(ship_date,  'YYYYMMDD'))   as ship_date_key,

    -- dimensiones degeneradas
    order_key,
    line_number,
    order_status,
    order_priority,
    return_flag,
    line_status,
    ship_mode,

    -- medidas
    quantity,
    extended_price,
    discount,
    tax,
    net_revenue,
    net_revenue_with_tax
from {{ ref('int_order_lines') }}
