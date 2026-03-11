/* 1. ADIM: CTE Yapısı ile Modelleri Çağırma
   dbt'de 'ref' fonksiyonu kullanarak staging tablolarımızı içeri alıyoruz.
*/
WITH sales AS (
    SELECT * FROM {{ ref('stg_raw__sales') }}
),

product AS (
    SELECT * FROM {{ ref('stg_raw__product') }}
),

/* 2. ADIM: Birleştirme ve Hesaplama Mantığı
   Satış tablosunu ürün tablosuyla 'products_id' üzerinden birleştiriyoruz.
*/
sales_with_costs AS (
    SELECT 
        s.*, -- Satış tablosundaki tüm orijinal kolonlar (date, quantity, revenue vb.)
        p.purchase_price, -- Ürün tablosundan gelen birim alış fiyatı
        
        -- Satın Alma Maliyeti Hesabı: Miktar * Birim Alış Fiyatı
        (s.quantity * p.purchase_price) AS purchase_cost,
        
        -- Marj (Kâr) Hesabı: Toplam Gelir - Toplam Satın Alma Maliyeti
        (s.revenue - (s.quantity * p.purchase_price)) AS margin

    FROM sales s --sales AS s
    LEFT JOIN product p 
        -- Belirttiğin 'products_id' kolonuna göre eşleştirme yapıyoruz
        ON s.products_id = p.products_id
)

/* 3. ADIM: Nihai Seçim
   Hesaplamaların yapıldığı tabloyu sonuç olarak döndürüyoruz.
*/
SELECT * FROM sales_with_costs