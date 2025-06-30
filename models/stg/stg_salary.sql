{{ 
    config(
        materialized = 'table',
        tags = ['stg']
    ) 
}}

SELECT
    employee_id,
    first_name,
    last_name,
    job_title,
    department_name,
    city,
    country_name,
    region_name,
    salary_date,
    hra,
    allowances,
    pf,
    load_time AS LOAD_TIME
FROM {{ source('hr', 'salary') }}
WHERE employee_id IS NOT NULL
