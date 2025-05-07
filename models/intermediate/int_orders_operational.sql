with sales_margin as (

    select *
    from {{ ref('int_sales_margin') }}

), aggregated as (

    select
        orders_id,
        min(date_date) as date_date, -- utile si plusieurs lignes par commande
        sum(revenue) as revenue,
        sum(quantity) as quantity,
        sum(purchase_cost) as purchase_cost,
        sum(margin) as margin

    from sales_margin
    group by orders_id

)

select * from aggregated
