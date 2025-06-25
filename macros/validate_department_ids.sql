{% test validate_department_ids(model,column_name) %}

select {{ column_name }} as invalid_depart_id
from  {{ model }}
where {{ column_name }} IS NOT NULL
AND {{ column_name }} NOT IN (
    SELECT DISTINCT DEPARTMENT_ID FROM {{ ref('dim_employees1')}}
)

{% endtest %}