-- فاز ۲ - پاکسازی داده و SQL
-- وظیفه: شناسایی و حذف رکوردهای تکراری در SQL (با کوئری DISTINCT)
-- مسئول: نفر A

-- ۱) شناسایی: چند رکورد کاملاً تکراری داریم؟
SELECT
    invoice, stock_code, description, quantity,
    invoice_date, price, customer_id, country,
    COUNT(*) AS n_duplicates
FROM raw_transactions
GROUP BY
    invoice, stock_code, description, quantity,
    invoice_date, price, customer_id, country
HAVING COUNT(*) > 1
ORDER BY n_duplicates DESC;

-- ۲) حذف: جدول جدید بدون رکوردهای تکراری با استفاده از DISTINCT
DROP TABLE IF EXISTS transactions_deduped;

CREATE TABLE transactions_deduped AS
SELECT DISTINCT
    invoice, stock_code, description, quantity,
    invoice_date, price, customer_id, country
FROM raw_transactions;

-- ۳) گزارش نتیجه
SELECT
    (SELECT COUNT(*) FROM raw_transactions)     AS total_before,
    (SELECT COUNT(*) FROM transactions_deduped) AS total_after,
    (SELECT COUNT(*) FROM raw_transactions)
        - (SELECT COUNT(*) FROM transactions_deduped) AS removed_count;
