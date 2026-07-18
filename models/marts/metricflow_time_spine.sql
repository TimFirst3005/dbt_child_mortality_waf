{{
    config(
        materialized='table',
    )
}}

with days as (
    select 
        generate_series as date_day
    from generate_series(
        date '1960-01-01',
        date '2030-12-31',
        interval '1 day'
    )
)

select date_day,
from days