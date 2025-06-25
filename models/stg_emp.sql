{{ config(materialized="incremental", unique_key="employee_id") }}

select
    
    employee_id,
    initcap(first_name) as first_name,
    initcap(last_name) as last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    current_timestamp as load_time
from {{source('EMP','employees')}} as src

{% if is_incremental() %}

where src.load_time >=(
    select(coalesce(max(load_time),'1900-01-01 00:00:00')) from {{this}}
)
 {% endif %}
