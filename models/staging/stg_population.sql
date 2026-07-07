with source as (
    select * from {{ source('raw', 'population') }}
),

renamed as (
    select
        country_code,
        country_name,
        year,
        population_total

    from source
)

select * from renamed