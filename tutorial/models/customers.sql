with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

customer_orders as (

        select
        customer_id,

        min(order_date) as date_first_order,
        max(order_date) as date_most_recent_order,
        count(order_id) as num_total_orders
    from orders

    group by customer_id

),

customer_payments as (

    select
        orders.customer_id,
        sum(amount) as total_amount

    from payments

    left join orders on
         payments.order_id = orders.order_id

    group by orders.customer_id

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.date_first_order,
        customer_orders.date_most_recent_order,
        customer_orders.num_total_orders, 
        customer_payments.total_amount as num_total_amount

    from customers

    left join customer_orders
        on customers.customer_id = customer_orders.customer_id

    left join customer_payments
        on  customers.customer_id = customer_payments.customer_id

)

select * from final