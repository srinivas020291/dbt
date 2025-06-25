select distinct
    employee_id,
    first_name,
    last_name,
    lower(email) as email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    current_timestamp as load_time
from {{ source('EMP','employees')}}