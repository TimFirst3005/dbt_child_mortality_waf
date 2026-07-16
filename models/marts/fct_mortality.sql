{{ 
    config(
    materialized='incremental',
    unique_key=['country_code', 'year'],
    incremental_strategy='delete+insert',
    )
}}


WITH mortality AS (
    select * from {{ ref('int_mortality_yoy_change') }}
),

population as (
    select * from {{ ref('stg_population') }}
),

final as (
    select
        m.country_code,
        m.year,
        m.under5_mortality_rate,
        m.mortality_severity,
        m.yoy_change_absolute,
        m.yoy_change_percent,
        p.population_total,

        round(
            m.under5_mortality_rate / 1000.0 * p.population_total 
        ) as estimated_affected_population

    from mortality m
    left join population p
        on m.country_code = p.country_code 
        and m.year = p.year
)

SELECT * FROM final

{% if is_incremental() %}
    WHERE year > (
        SELECT coalesce(max(year), 0) FROM {{ this }}
)
{% endif %}