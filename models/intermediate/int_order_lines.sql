{# Une líneas de pedido con su cabecera (cambia el detalle a nivel línea + atributos del pedido)
   y calcula los ingresos usando la macro net_revenue. #}

select
    l.order_key,
    l.line_number,
    o.customer_key,
    l.part_key,
    l.supplier_key,
    o.order_date,
    l.ship_date,
    o.order_status,
    o.order_priority,
    l.return_flag,
    l.line_status,
    l.ship_mode,
    l.quantity,
    l.extended_price,
    l.discount,
    l.tax,
    {{ net_revenue('l.extended_price', 'l.discount') }}                 as net_revenue,
    {{ net_revenue('l.extended_price', 'l.discount', 'l.tax') }}        as net_revenue_with_tax
from {{ ref('stg_lineitem') }} as l
inner join {{ ref('stg_orders') }} as o
    on l.order_key = o.order_key
