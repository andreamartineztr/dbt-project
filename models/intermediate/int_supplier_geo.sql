{# Proveedor + nación + región #}

select
    s.supplier_key,
    s.supplier_name,
    s.address,
    s.phone,
    s.account_balance,
    n.nation_key,
    n.nation_name,
    r.region_key,
    r.region_name
from {{ ref('stg_supplier') }} as s
left join {{ ref('stg_nation') }} as n on s.nation_key = n.nation_key
left join {{ ref('stg_region') }} as r on n.region_key = r.region_key
