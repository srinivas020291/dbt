{{
    config(
        materialized='incremental',
        unique_key = 'LOCATION_ID',
        incremental_strategy='delete+insert',
        tags=['dim']
    )
}}

select 

LOCATION_ID,
STREET_ADDRESS,
POSTAL_CODE,
INITCAP(CITY) as city,
INITCAP(STATE_PROVINCE) as state,
COUNTRY_ID,
city || STATE_PROVINCE as full_address,
current_timestamp as load_time
from {{ ref('stg_locations') }}

{% if is_incremental() %}

{{ incr() }}

{% endif %}