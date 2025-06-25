select {{ multi_cap('first_name','last_name') }}
from {{ source('EMP','employees') }}