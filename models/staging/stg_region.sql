
select
    r_regionkey                                as region_key,
    {{ clean_text('r_name', 'title') }}        as region_name,
    r_comment                                  as comment,
    current_timestamp()                        as _loaded_at
from {{ source('tpch', 'region') }}