with source as (  
  select
    *
  from {{source("sheets", "customer_survey_responses")}}
),

final as (  
  select
   *
  from source
)

select
  *
from final    