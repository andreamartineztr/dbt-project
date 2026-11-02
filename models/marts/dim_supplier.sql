select
    supplier_key,
    supplier_name,
    address,
    phone,
    account_balance,
    nation_key,
    nation_name,
    region_key,
    region_name
from {{ ref('int_supplier_geo') }}
