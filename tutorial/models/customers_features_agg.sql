{% set cols = dbtplyr.get_column_names( ref('customers') ) %}
{% set cols_date = dbtplyr.starts_with('date_', cols) %}
{% set cols_num = dbtplyr.starts_with('num_', cols) %}

select
    customer_id,
    {{ dbtplyr.across(cols_num, "sum({{var}}) as {{var}}_tot") }}
from 
    {{ ref('customers') }}
group by 1