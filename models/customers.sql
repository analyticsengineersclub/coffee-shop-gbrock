{{ config(
    materialized='table'
) }}

with
 first_order as (
     select
         customer_id,
         min(created_at) as first_order_at
     from `analytics-engineers-club.coffee_shop.orders`
     group by 1
 ),
 total_orders as (
     select
         customer_id,
         count(*) as number_of_orders
     from `analytics-engineers-club.coffee_shop.orders`
     group by 1
 )
 select
     id as customer_id,
     name,
     email,
     first_order_at,
     number_of_orders
 from `analytics-engineers-club.coffee_shop.customers` c
 left join first_order on c.id = first_order.customer_id
 left join total_orders on c.id = total_orders.customer_id
 order by first_order_at 
