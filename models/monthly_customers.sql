select 
    date_trunc(first_order_at, month) as month_of,
    count(distinct customer_id) as monthly_customers
from {{ ref('customers') }} 
group by 1
order by 1
