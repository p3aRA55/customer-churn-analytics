-- فاز ۲ - پاکسازی داده و SQL
-- وظیفه: استانداردسازی قالب داده‌ها در SQL (تبدیل تاریخ/متن به فرمت یکنواخت)
-- مسئول: نفر A
-- ورودی: جدول transactions_deduped (خروجی مرحله قبل)

DROP TABLE IF EXISTS transactions_standardized;

CREATE TABLE transactions_standardized AS
SELECT
    UPPER(TRIM(invoice))              AS invoice,
    UPPER(TRIM(stock_code))           AS stock_code,
    INITCAP(TRIM(description))        AS description,
    quantity,
    -- تضمین می‌کنیم invoice_date از نوع timestamp استاندارد باشد
    invoice_date::timestamp           AS invoice_date,
    ROUND(price::numeric, 2)          AS price,
    customer_id,
    -- یکدست‌سازی نام کشورها (حذف فاصله اضافه و یکسان‌سازی حروف بزرگ/کوچک)
    INITCAP(TRIM(country))            AS country
FROM transactions_deduped;

-- بررسی سریع نتیجه
SELECT invoice, stock_code, description, invoice_date, price, country
FROM transactions_standardized
LIMIT 20;
