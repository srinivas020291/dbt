select 
    EMPLOYEE_ID,
    FIRST_NAME || ' ' || LAST_NAME as FULL_NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID
from {{ ref("tgt_employees") }}
where SALARY >9000
 