/* 1. ADIM: CTE Yapısı ile Modelleri Çağırma
   dbt'de 'ref' fonksiyonu kullanarak staging tablolarımızı içeri alıyoruz.
*/

 WITH ship AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
),
sales_margin AS (
    SELECT * FROM {{ ref('int_sales_margin') }}
),

/* 2. ADIM: Birleştirme ve Hesaplama Mantığı
   Ship ve sales_margin tablosunu ürün tablosuyla 'orders_id' üzerinden birleştiriyoruz.
*/
orders_with_costs AS (
    SELECT 
        sm.orders_id,
        sm.date_date,
        sm.revenue,
        sm.quantity,
        sm.purchase_cost,
        sm.margin
        
        

    FROM int_sales_margin sm --int_sales_margin AS sm

)

/* 3. ADIM: Nihai Seçim
   Hesaplamaların yapıldığı tabloyu sonuç olarak döndürüyoruz.
*/
SELECT * FROM orders_with_costs