{{ config(materialized="incremental", 
        unique_key="employee_id") 
}}


select

    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    current_timestamp as load_time
from {{ ref("stg_employees")}}

{% if is_incremental() %}

where load_time>=(
        select (coalesce(max(load_time),'1900-01-01 00:00:00')) from {{this}}
)

{% endif %}
