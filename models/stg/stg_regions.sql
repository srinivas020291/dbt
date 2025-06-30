{{
    config(
        materialized='table',
        tags = ['stg']
    )
}}

select

REGION_ID,
initcap(REGION_NAME) as REGION_NAME,
current_timestamp as load_time

from {{ source('hr','regions') }}
where REGION_ID is NOT NULL