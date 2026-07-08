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
        {{ classify_mortality_severity('under5_mortality_rate') }} as mortality_severity

    from source
    where year >= {{ var('minimum_valid_year') }} 
)

select * from renamed