{# Cliente + nación + región (desnormaliza la jerarquía geográfica) #}

select
    c.customer_key,
    c.customer_name,
    c.address,
    c.phone,
    c.account_balance,
    c.market_segment,
    n.nation_key,
    n.nation_name,
    r.region_key,
    r.region_name
from {{ ref('stg_customer') }} as c
left join {{ ref('stg_nation') }} as n on c.nation_key = n.nation_key
left join {{ ref('stg_region') }} as r on n.region_key = r.region_key
