-- TEST DE REGLA DE NEGOCIO: no se puede enviar un pedido antes de haberlo realizado.
select order_key, line_number, order_date, ship_date
from {{ ref('int_order_lines') }}
where ship_date < order_date
