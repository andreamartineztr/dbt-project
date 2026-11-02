select
    customer_key,
    customer_name,
    address,
    phone,
    account_balance,
    market_segment,
    nation_key,
    nation_name,
    region_key,
    region_name
from {{ ref('int_customer_geo') }}
