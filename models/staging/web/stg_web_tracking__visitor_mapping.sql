select
    customer_id,
    min(visitor_id) as visitor_id
from {{ ref('stg_web_tracking__pageviews') }}
where visitor_id is not null
    and customer_id is not null
group by 1