{% set west_africa_codes = ['CIV', 'SEN', 'NGA', 'GHA', 'MLI'] %}

select
    year,
    {% for code in west_africa_codes %}
    max(case when country_code = '{{ code }}' then under5_mortality_rate end) as mortality_{{ code | lower }}
    {%- if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('stg_child_mortality') }}
group by year
order by year