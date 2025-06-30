{% snapshot employee_snap %}

{{

    config(target_schema = 'HR_DEV',
        unique_key =' employee_id',
        strategy='timestamp',
        updated_at='load_time',
        invalidated_hard_deletes = true)
}}

select 
    employee_id,
    first_name,
    last_name,
    salary,
    load_time
from {{ source('EMP','employees1') }}

{% endsnapshot %}