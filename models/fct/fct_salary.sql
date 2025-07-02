{{
    config(
        materialized='incremental',
        unique_key='employee_id',
        incremental_strategy='delete+insert',
        tags=['fct']
    )
}}

{% set x = "(select coalesce(max(load_time),'1900-01-01 00:00:00') from " ~ this ~ ")" %}

select 
emp.employee_id,
dept.department_id,
job.job_id,
loc.location_id,
con.country_id,
reg.region_id,
sal.salary_date,
emp.salary as basic_salary,
sal.hra,
sal.ALLOWANCES,
sal.pf,
(emp.salary+sal.hra+sal.allowances+sal.pf) as gross_salary,
(emp.salary+sal.hra+sal.allowances) as net_salary,
current_timestamp as load_time
from {{ ref('stg_salary') }} as sal
join {{ ref('dim_employees') }} as emp
on sal.employee_id = emp.employee_id
join {{ ref('dim_departments')}} as dept
on emp.department_id=dept.department_id
join {{ ref('dim_locations') }} as loc
on loc.location_id = dept.location_id
join {{ ref('dim_countries') }} as con
on loc.country_id = con.country_id
join {{ ref('dim_regions')}} as reg
on con.region_id = reg.region_id
join {{ ref('dim_jobs') }} as job
on emp.job_id = job.job_id

{% if is_incremental() %}

where sal.load_time> {{ x }}

or emp.load_time > {{ x }}

or dept.load_time > {{ x }}

or loc.load_time > {{ x }}

or con.load_time > {{ x }}

or reg.load_time > {{ x }}

or job.load_time > {{ x }}

{% endif %}

