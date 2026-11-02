{# Dimensión calendario generada con SQL (sin depender del origen): 1992-01-01 .. ~2000-03 #}

with dates as (
    select dateadd(day, row_number() over (order by seq4()) - 1, to_date('1992-01-01')) as date_day
    from table(generator(rowcount => 3000))
)

select
    to_number(to_char(date_day, 'YYYYMMDD'))   as date_key,
    date_day,
    year(date_day)                             as year,
    quarter(date_day)                          as quarter,
    month(date_day)                            as month,
    monthname(date_day)                        as month_name,
    day(date_day)                              as day_of_month,
    dayofweekiso(date_day)                     as day_of_week_iso,
    dayname(date_day)                          as day_name,
    dayofweekiso(date_day) >= 6                as is_weekend
from dates
