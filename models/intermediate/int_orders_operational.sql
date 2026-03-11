WITH ship AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
),

orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),

orders_operational AS (
    SELECT 
        om.orders_id,
        om.date_date,
        om.margin,
        sh.shipping_fee, 
        sh.logcost,
        sh.ship_cost
        

        (sm.margin + sh.shipping_fee - sh.logcost - sh.ship_cost) AS operational_marg,


    FROM orders_operational AS om -- Yukarıdaki CTE ismini kullandık
    LEFT JOIN ship AS sh 
        ON om.orders_id = sh.orders_id -- om ile sh'ı bağladık
)

SELECT * FROM orders_operational