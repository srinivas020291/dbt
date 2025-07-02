{{ 
    config(materialized='table',
            tags = ['stg']) 
    }}

select 
    location_id, 
    street_address, 
    postal_code, 
    city, 
    state_province, 
    country_id,
    current_timestamp as load
from {{ source('hr','locations') }}
where city is NOT NULL
