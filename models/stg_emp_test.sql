{{      
        config(materialized='incremental', 
        unique_key='employee_id',
        incremental_strategy='insert_overwrite',
        partition_by={'field':'load_time', 'data_type':'timestamp'}
        
       )

 }}

select distinct
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id,
    current_timestamp as load_time
    from {{ source('EMP', 'employees1') }} as src


    {% if is_incremental() %}

        where src.load_time>=dateadd(day,-7,current_timestamp)
           

    {% endif %}
    
