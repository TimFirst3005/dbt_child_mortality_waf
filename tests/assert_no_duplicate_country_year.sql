-- Ce test échoue si un couple (country_code, year) apparaît plus d'une fois
-- dans le modèle enrichi, ce qui signalerait un doublon issu de la jointure
select 
    country_code,
    year,
    count(*) as nb_occurrences
from {{ ref('int_mortality_enriched') }}
group by country_code, year
having count(*) > 1