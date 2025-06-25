{% macro multi_cap(a,b) %}

{% set col=[a,b] %}

    {% for column in col %}

        upper({{ column }}),

    {% endfor %}

{% endmacro %}