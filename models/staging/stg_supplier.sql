select
    s_suppkey                                  as supplier_key,
    {{ clean_text('s_name') }}                 as supplier_name,
    {{ clean_text('s_address') }}              as address,
    s_nationkey                                as nation_key,
    {{ clean_text('s_phone') }}                as phone,
    s_acctbal                                  as account_balance,
    s_comment                                  as comment,
    current_timestamp()                        as _loaded_at
from {{ source('tpch', 'supplier') }}