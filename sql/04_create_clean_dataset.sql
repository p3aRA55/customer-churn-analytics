-- فاز ۲ - پاکسازی داده و SQL
-- وظیفه: ایجاد مجموعه داده تمیز نهایی (ذخیره نتایج در جدول جدید یا فایل)
-- مسئول: نفر A
-- توجه: اگر نفر B مقادیر گمشده را در Python (pandas) پردازش کرده،
-- خروجی او را قبل از این مرحله در دیتابیس بارگذاری کن (جدول transactions_final_input)
-- و FROM را به همان جدول تغییر بده. در غیر این صورت این نسخه مستقیماً از
-- transactions_standardized ساخته می‌شود و ردیف‌های بدون شناسه مشتری/تعداد نامعتبر حذف می‌شوند.

DROP TABLE IF EXISTS clean_transactions;

CREATE TABLE clean_transactions AS
SELECT *
FROM transactions_standardized
WHERE
    customer_id IS NOT NULL
    AND quantity > 0
    AND price > 0;

-- خلاصه نهایی برای مستندسازی (وظیفه بعدی نفر B)
SELECT
    (SELECT COUNT(*) FROM raw_transactions)          AS raw_rows,
    (SELECT COUNT(*) FROM transactions_deduped)      AS after_dedup,
    (SELECT COUNT(*) FROM transactions_standardized) AS after_standardize,
    (SELECT COUNT(*) FROM clean_transactions)        AS final_clean_rows;

-- خروجی به فایل (اجرا در psql، نه در این اسکریپت):
-- \copy clean_transactions TO 'data/processed/clean_transactions.csv' WITH CSV HEADER
