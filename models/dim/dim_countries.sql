{{
    config(
        materialized='incremental',
        unique_key='COUNTRY_ID',
        incremental_strategy='delete+insert',
        tags=['dim']
    )
}}

select
COUNTRY_ID,
INITCAP(COUNTRY_NAME) as COUNTRY_NAME,
REGION_ID,
current_timestamp as load_time

from {{ ref('stg_countries') }}

{% if is_incremental() %}

{{ incr() }}

{%  endif %}