select
    ps_partkey                 as part_key,
    ps_suppkey                 as supplier_key,
    ps_availqty                as available_quantity,
    ps_supplycost              as supply_cost,
    ps_comment                 as comment,
    current_timestamp()        as _loaded_at
from {{ source('tpch', 'partsupp') }}
