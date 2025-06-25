{{ config(materialized="table") }}

select
    department_id,
    department_name,
    manager_id,
    location_id,
    current_timestamp as load_time
from {{source('EMP','department')}}