# TPCH_SF1 · Data Warehouse con dbt + Snowflake

Proyecto ETL (ELT) que parte del dataset `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1` y construye una arquitectura de 3 capas hasta llegar a un **modelo dimensional en estrella**.

## Arquitectura

```
SNOWFLAKE_SAMPLE_DATA.TPCH_SF1  (8 tablas origen)
        │
        ▼
  STAGING (tablas)            stg_* · 8 entidades · stg_orders INCREMENTAL, resto carga total
        │
        ▼
  INTERMEDIATE (vistas)       int_order_lines · int_customer_geo · int_supplier_geo
        │
        ▼
  MARTS / BUSINESS (tablas)   fct_order_lines + dim_customer · dim_supplier · dim_part · dim_date
```

| Capa | Esquema | Materialización | Carga | Justificación |
|---|---|---|---|---|
| Staging | `STAGING` | `table` (`incremental` en `stg_orders`) | Total / incremental en orders | Extracción rápida y desacoplada del origen |
| Transformation | `INTERMEDIATE` | `view` | Total | Joins ligeros, nadie los consulta directamente: no se ocupa almacenamiento |
| Business | `MARTS` | `table` | Total | Rendimiento de consulta para BI |

## Modelo en estrella

`fct_order_lines` (granularidad: **línea de pedido**) → `dim_customer` (con nación/región), `dim_supplier` (con nación/región), `dim_part`, `dim_date` (rol *order date* y *ship date*).

Medidas: `quantity`, `extended_price`, `discount`, `tax`, `net_revenue`, `net_revenue_with_tax`.

## Macros
- `net_revenue(extended_price, discount, tax=0)`: única definición del ingreso neto.
- `generate_schema_name`: nombres de esquema limpios (`STAGING`, `INTERMEDIATE`, `MARTS`).

## Tests
- **Unitarios** (`models/intermediate/_int_models.yml`): validan la macro y el join con datos simulados.
- **Genéricos**: `unique`, `not_null`, `relationships`, `accepted_values`, `dbt_utils.*`.
- **Singulares** (`tests/`): reconciliación de ingresos contra el origen, volumetría y regla de negocio de fechas.

## Cómo ejecutarlo

```bash
pip install -r requirements.txt
cp profiles.yml.example ~/.dbt/profiles.yml     # y define SNOWFLAKE_ACCOUNT / USER / PASSWORD
dbt deps
dbt debug
dbt build            # ejecuta modelos + tests (incl. unitarios) en orden de dependencia
dbt docs generate && dbt docs serve   # linaje
```

Antes, ejecutar `snowflake/setup_snowflake.sql` en Snowflake (crea warehouse, base de datos y rol).

## Demo de la carga incremental

```bash
# 1) carga inicial parcial (pedidos hasta 1996)
dbt run -s stg_orders --full-refresh --vars '{initial_load_until: "1996-12-31"}'
# 2) carga incremental: añade el resto de pedidos (MERGE por order_key)
dbt run -s stg_orders
# 3) reconstruir el resto
dbt build
```
