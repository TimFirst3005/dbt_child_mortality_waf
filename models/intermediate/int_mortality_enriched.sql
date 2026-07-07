with mortality as (
    select
        *
    from {{ ref('stg_child_mortality') }}
),

population as (
    select
        *
    from {{ ref('stg_population') }}
),

joined as (
    select
        m.country_code,
        m.country_name,
        m.year,
        m.under5_mortality_rate,
        m.mortality_severity,
        p.population_total,

        -- estimation du nombre absolu d'enfants concernés (indicatif, pour la pédagogie)
        round(
            m.under5_mortality_rate / 1000.0 * p.population_total
        ) as estimated_affected_population

    from mortality m
    left join population p
        on m.country_code = p.country_code and m.year = p.year
)

select * from joined