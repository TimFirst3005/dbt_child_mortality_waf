{% snapshot snap_child_mortality %}

{{
    config(
        target_schema='snapshots',
        unique_key="country_code || '-' || year",
        strategy='check',
        check_cols=['under5_mortality_rate', 'mortality_severity'],
    )
}}

select
    country_code,
    country_name,
    year,
    under5_mortality_rate,
    mortality_severity
from {{ ref('stg_child_mortality') }}

{% endsnapshot %} 