-- TEST DE VOLUMETRÍA: la fact debe tener tantas filas como líneas de pedido con pedido en el origen.
with fact as (select count(*) as n from {{ ref('fct_order_lines') }}),
source as (
    select count(*) as n
    from {{ source('tpch', 'lineitem') }} as l
    inner join {{ source('tpch', 'orders') }} as o on l.l_orderkey = o.o_orderkey
)
select fact.n as fact_rows, source.n as source_rows
from fact cross join source
where fact.n <> source.n
