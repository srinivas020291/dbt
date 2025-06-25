select
    e.employee_id,
    e.first_name || ' ' || e.last_name as full_name,
    e.email,
    e.phone_number,
    e.hire_date,
    e.job_id,
    e.salary,
    e.commission_pct,
    e.manager_id,
    e.department_id,
    current_timestamp as load_time
from {{ ref('stg_employees1')}} e