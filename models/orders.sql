with orders as (
    select *
    from {{ ref('stg_orders') }}
)

, payment as (
    select *
    from {{ ref('stg_payment') }}
)

select
    orders.order_id
  , orders.customer_id
  , orders.order_date
  , orders.status
  , sum(payment.amount) as amount

from orders 
left join payment
    on orders.order_id = payment.order_id

where orders.status = 'success'

group by 1, 2, 3, 4