with countries AS (
    SELECT DISTINCT
        country_code,
        country_name
    FROM {{ ref("stg_child_mortality") }}
),

reference AS (
    SELECT * FROM {{ ref("seed_country_reference") }}
),

final AS (
    SELECT 
        c.country_code,
        c.country_name,
        r.sub_region,
        r.official_language,
        r.is_landlocked
    FROM countries c
    LEFT JOIN reference r
    ON c.country_code = r.country_code
)

SELECT * FROM final