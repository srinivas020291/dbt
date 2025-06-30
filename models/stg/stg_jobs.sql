

{{
    config(
        materialized='table',
        tags = ['stg']
    )
}}

select 
    
JOB_ID,
JOB_TITLE,
MIN_SALARY,
MAX_SALARY,
current_timestamp as load_time
from {{ source('hr','jobs') }}
where job_id is NOT NULL