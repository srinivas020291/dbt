{{
    config(
        materialized='incremental',
        unique_key='job_id',
        incremental_strategy='delete+insert',
        tags=['dim']
    )
}}

select 

JOB_ID,
INITCAP(JOB_TITLE) as JOB_TITLE,
MIN_SALARY,
MAX_SALARY,
current_timestamp as load_time

from {{ ref('stg_jobs') }}

{% if is_incremental() %}

{{ incr() }}

{% endif %}