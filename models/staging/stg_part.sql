select
    p_partkey                                  as part_key,
    {{ clean_text('p_name') }}                 as part_name,
    {{ clean_text('p_mfgr') }}                 as manufacturer,
    {{ clean_text('p_brand') }}                as brand,
    {{ clean_text('p_type', 'upper') }}        as part_type,
    p_size                                     as size,
    {{ clean_text('p_container', 'upper') }}   as container,
    p_retailprice                              as retail_price,
    p_comment                                  as comment,
    current_timestamp()                        as _loaded_at
from {{ source('tpch', 'part') }}