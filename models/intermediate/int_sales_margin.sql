with sales as (

    select *
    from {{ ref('stg_raw__sales') }}

), product as (

    select *
    from {{ ref('stg_raw__product') }}

), joined as (

    select
        sales.date_date,
        sales.orders_id,
        sales.products_id,
        sales.quantity,
        sales.revenue,
        product.purchase_price,

        -- Calcule du coût d'achat
        sales.quantity * product.purchase_price as purchase_cost,

        -- Calcule de la marge
        sales.revenue - (sales.quantity * product.purchase_price) as margin

    from sales
    left join product
        on sales.products_id = product.products_id

)

select * from joined
