select
    c_custkey                                  as customer_key,
    {{ clean_text('c_name') }}                 as customer_name,
    {{ clean_text('c_address') }}              as address,
    c_nationkey                                as nation_key,
    {{ clean_text('c_phone') }}                as phone,
    c_acctbal                                  as account_balance,
    {{ clean_text('c_mktsegment', 'upper') }}  as market_segment,
    c_comment                                  as comment,
    current_timestamp()                        as _loaded_at
from {{ source('tpch', 'customer') }}