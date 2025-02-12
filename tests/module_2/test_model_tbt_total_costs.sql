{{ config(enabled=false) }}

select *
from {{ ref('model_tbt') }}
where quantity * price != total
limit 5
