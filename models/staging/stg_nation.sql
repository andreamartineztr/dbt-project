select
    n_nationkey                                as nation_key,
    {{ clean_text('n_name', 'title') }}        as nation_name,
    n_regionkey                                as region_key,
    n_comment                                  as comment,
    current_timestamp()                        as _loaded_at
from {{ source('tpch', 'nation') }}