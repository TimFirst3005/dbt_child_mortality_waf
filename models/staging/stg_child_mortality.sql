with source as (
    select * from {{ ref('raw_child_mortality') }}
),

renamed as (
    select
        country_code,
        country_name,
        year,
        under5_mortality_rate,

        -- petite classification utile pour la suite (couche marts)
        case 
            when under5_mortality_rate >= 100 then 'Critique'
            when under5_mortality_rate >= 50 then 'Elevé'
            else 'Modéré'
        end as mortality_severity

    from source
)

select * from renamed