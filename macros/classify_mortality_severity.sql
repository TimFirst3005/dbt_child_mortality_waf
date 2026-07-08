{% macro classify_mortality_severity(colomn_name) %}
    case 
        when {{ colomn_name }} >= 100 then 'Critique'
        when {{ colomn_name }} >= 50 then 'Elevé'
        else 'Modéré'
    end
{% endmacro %}