{{ 
    config(
        materialized='incremental',
        unique_key='employee_id',

        pre_hook=[
            "INSERT INTO emp.audit_log (
                MODEL_NAME,
                RUN_ID,
                START_TIME,
                END_TIME,
                RUN_BY_USER
            ) VALUES (
                'stg_name',
                '{{ invocation_id }}',
                CURRENT_TIMESTAMP,
                NULL,
                CURRENT_USER
            )"
        ],

        post_hook=[
            "UPDATE emp.audit_log
             SET END_TIME = CURRENT_TIMESTAMP
             WHERE MODEL_NAME = 'stg_name'
             AND RUN_ID = '{{ invocation_id }}'"
        ]
    ) 
}}

SELECT distinct
    employee_id,
    INITCAP(first_name) AS first_name,
    INITCAP(last_name) AS last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    CURRENT_TIMESTAMP AS load_time
FROM {{ source('EMP', 'employees') }}
