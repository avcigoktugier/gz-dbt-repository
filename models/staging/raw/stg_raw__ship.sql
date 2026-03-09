with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
        -- shipping_fee_1 birebir aynı olduğu için çıkarıldı
        logcost,
        TRUNC(CAST(ship_cost AS FLOAT64), 5) AS ship_cost

    from source

)

select * from renamed