{{
    config(
        materialized='incremental',
        unique_key='order_key',
        incremental_strategy='merge'
    )
}}

{#
  CARGA INCREMENTAL (única entidad incremental de staging).
  - Primera ejecución / --full-refresh: carga todo (o hasta la fecha de la variable
    initial_load_until, útil para la demo).
  - Ejecuciones siguientes: sólo pedidos con order_date >= máxima fecha ya cargada.
    Se usa ">=" (no ">") para recoger pedidos tardíos del último día; el MERGE por
    order_key evita duplicados.
#}

select
    o_orderkey                 as order_key,
    o_custkey                  as customer_key,
    o_orderstatus              as order_status,
    o_totalprice               as total_price,
    o_orderdate                as order_date,
    o_orderpriority            as order_priority,
    o_clerk                    as clerk,
    o_shippriority             as ship_priority,
    o_comment                  as comment,
    current_timestamp()        as _loaded_at
from {{ source('tpch', 'orders') }}

{% if is_incremental() %}
where o_orderdate >= (select max(order_date) from {{ this }})
{% elif var('initial_load_until', none) is not none %}
where o_orderdate <= '{{ var("initial_load_until") }}'
{% endif %}
