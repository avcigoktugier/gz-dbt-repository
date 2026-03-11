WITH source AS (
    -- Bir önceki adımda oluşturduğumuz source referansını kullanıyoruz
    SELECT * FROM {{ source('raw', 'sales') }}
),

renamed AS (
    SELECT
        orders_id,
        pdt_id AS products_id,  -- Hatanın çözümü buradaki AS kullanımında
        date_date,
        revenue,
        quantity
    FROM source
)

SELECT * FROM renamed
