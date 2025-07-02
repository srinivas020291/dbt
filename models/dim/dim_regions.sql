{{
    config(
        materialized='incremental',
        unique_key='REGION_ID',
        incremental_strategy='delete+insert',
        tags=['dim']
    )
}}

select 

REGION_ID,
INITCAP(REGION_NAME) as REGION_NAME,
current_timestamp as load_time
from {{ ref('stg_regions') }}

{% if is_incremental() %}

{{ incr() }}

{% endif %}