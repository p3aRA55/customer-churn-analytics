-- Retail Customer Churn Analytics schema
-- Placeholder schema for initial database setup

CREATE TABLE IF NOT EXISTS customers (
    customer_id BIGINT PRIMARY KEY,
    country VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS transactions (
    invoice VARCHAR(50),
    customer_id BIGINT REFERENCES customers(customer_id),
    product VARCHAR(255),
    quantity INTEGER,
    price NUMERIC(10, 2),
    invoice_date DATE,
    country VARCHAR(100)
);
