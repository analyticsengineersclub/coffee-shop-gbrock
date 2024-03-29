{{ config(
    materialized='table'
) }}

with
 first_order as (
     select
         customer_id,
         min(created_at) as first_order_at
     from {{ source('coffee_shop', 'orders') }} as orders
     group by 1
 ),
 total_orders as (
     select
         customer_id,
         count(*) as number_of_orders
     from {{ source('coffee_shop', 'orders') }} as orders
     group by 1
 )
 select
     id as customer_id,
     name,
     email,
     first_order_at,
     number_of_orders
 from {{ source('coffee_shop', 'customers') }} as c
 left join first_order on c.id = first_order.customer_id
 left join total_orders on c.id = total_orders.customer_id
 order by first_order_at 
