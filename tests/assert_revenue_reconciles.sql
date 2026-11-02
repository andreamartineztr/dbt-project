-- TEST DE RECONCILIACIÓN: el ingreso neto total de la tabla de hechos debe coincidir
-- con el calculado directamente desde el ORIGEN (sin pasar por dbt ni la macro).
-- Si devuelve filas => el test FALLA.
with fact as (
    select sum(net_revenue) as total from {{ ref('fct_order_lines') }}
),
source as (
    select sum(round(l.l_extendedprice * (1 - l.l_discount), 2)) as total
    from {{ source('tpch', 'lineitem') }} as l
    inner join {{ source('tpch', 'orders') }} as o
        on l.l_orderkey = o.o_orderkey
)
select
    fact.total   as fact_total,
    source.total as source_total
from fact
cross join source
where abs(fact.total - source.total) > 0.01
