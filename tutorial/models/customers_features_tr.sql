{% set cols = dbtplyr.get_column_names( ref('customers') ) %}
{% set cols_date = dbtplyr.starts_with('date_', cols) %}
{% set cols_num = dbtplyr.starts_with('num_', cols) %}

select
    customer_id,
    {{ dbtplyr.across(cols_date, "cast({{var}} as timestamp) as {{var}}")}}
from 
    {{ ref('customers') }}
where
    {% for col in cols_date -%}
    {{col}} >= cast('2018-02-01' as date) or
    {% endfor %}

    FALSE