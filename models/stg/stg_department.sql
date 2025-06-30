    {{
        config(
            materialized='table',
            tags = ['stg']
        )
    }}



select     
    DEPARTMENT_ID,
    DEPARTMENT_NAME,
    MANAGER_ID,
    LOCATION_ID,
    current_timestamp as load_time
from {{ source('hr','departments') }}