{{ config(materialized='ephemeral') }}

with staging as (
    select
        *
    from {{ ref('stg_child_mortality') }}
),

with_previous_year as (
    select
        country_code,
        country_name,
        year,
        under5_mortality_rate,
        mortality_severity,

        -- Le taux de mortalité de l'année précédente pour chaque pays ordoné par année
        lag(under5_mortality_rate) over (
            partition by country_code 
            order by year
            ) as previous_year_rate

    from staging
),

final as (
    select
        *,
        round(under5_mortality_rate - previous_year_rate, 2) as yoy_change_absolute,
        round(
            100.0 * (under5_mortality_rate - previous_year_rate) / nullif(previous_year_rate, 0), 
            2
        ) as yoy_change_percent

    from with_previous_year
)

select * from final