select
    pageviews.pageview_id,
    mapping.visitor_id,
    pageviews.device_type,
    pageviews.timestamp,
    pageviews.page,
    pageviews.customer_id
from {{ ref('stg_web_tracking__pageviews') }} as pageviews
left join {{ ref('stg_web_tracking__visitor_mapping') }} as mapping on pageviews.customer_id = mapping.customer_id