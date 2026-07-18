with source as (
    select * from {{ ref("seed_raw_population_fixture") }}
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