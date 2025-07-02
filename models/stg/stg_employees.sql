{{
    config(
        materialized='table',
        tags = ['stg']
    )
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
from {{ source('hr','employees') }}
where employee_id is NOT NULL
