{% snapshot employee_snapshot %}
{{
    config(target_schema='HR_DEV',
            unique_key='employee_id',
            strategy='check',
            check_cols=['employee_id','first_name','last_name','load_time'],
            invalidate_hard_deletes=true)

}}

select 
    employee_id,
    first_name,
    last_name,
    load_time
from {{ source('EMP', 'employees1') }} 

{% endsnapshot %}