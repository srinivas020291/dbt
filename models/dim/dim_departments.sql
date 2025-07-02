{{
    config(
        materialized='incremental',
        unique_key='department_id',
        incremental_strategy='delete_insert',
        tags=['DIM']
    )
}}

select 

DEPARTMENT_ID,
INITCAP(DEPARTMENT_NAME) as DEPARTMENT_NAME,
MANAGER_ID,
LOCATION_ID,
current_timestamp as load_time
from {{ ref('stg_department') }}

{% if is_incremental() %}

{{ incr() }}

{% endif %}
