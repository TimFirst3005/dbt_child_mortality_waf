with intermediate as (
    select
        *
    from {{ ref('int_mortality_yoy_change') }}
),

final as (
    select
        country_code,
        country_name,
        year,
        under5_mortality_rate,
        mortality_severity,
        yoy_change_absolute,
        yoy_change_percent,

        -- indicateur simple : tendance à la baisse ou à la hausse du taux de mortalité
        case
            when yoy_change_absolute < 0 then 'Amélioration'
            when yoy_change_absolute > 0 then 'Dégradation'
            else 'Stable'
        end as mortality_trend

    from intermediate
)

select * from final