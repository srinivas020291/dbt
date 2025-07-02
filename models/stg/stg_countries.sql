{{
    config(
        materialized='table',
        tags = ['stg']
    )
}}

select 
    COUNTRY_ID,
    COUNTRY_NAME,
    REGION_ID,
    current_timestamp as load_time
from {{ source('hr','countries') }}
where country_id is NOT NULL