select
    l_orderkey                                 as order_key,
    l_partkey                                  as part_key,
    l_suppkey                                  as supplier_key,
    l_linenumber                               as line_number,
    l_quantity                                 as quantity,
    l_extendedprice                            as extended_price,
    l_discount                                 as discount,
    l_tax                                      as tax,
    l_returnflag                               as return_flag,
    l_linestatus                               as line_status,
    l_shipdate                                 as ship_date,
    l_commitdate                               as commit_date,
    l_receiptdate                              as receipt_date,
    {{ clean_text('l_shipinstruct', 'upper') }} as ship_instruction,
    {{ clean_text('l_shipmode', 'upper') }}    as ship_mode,
    l_comment                                  as comment,
    current_timestamp()                        as _loaded_at
from {{ source('tpch', 'lineitem') }}
