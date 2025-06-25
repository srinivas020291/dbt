{% macro y(name,designation) %}

select 'Hello {{name}}, your designation is: {{designation}}'

{% endmacro %}