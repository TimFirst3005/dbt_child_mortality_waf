-- Ce test échoue si des taux de mortalité sont en dehors de la plage [0, 1000]
select 
    country_code,
    year,
    under5_mortality_rate
from {{ ref('stg_child_mortality') }}
where 
    under5_mortality_rate < 0 
    or under5_mortality_rate > 1000