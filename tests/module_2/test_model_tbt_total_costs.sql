select *
from {{ ref('model_tbt') }}
where quantity * price != total
