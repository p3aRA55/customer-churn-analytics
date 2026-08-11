
import os
import sys
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()

import pandas as pd
from sqlalchemy import create_engine

RAW_DATA_DIR = Path("data/raw")
TABLE_NAME = "raw_transactions"

# ستون‌های استاندارد دیتاست Online Retail II
EXPECTED_COLUMNS = {
    "Invoice": "invoice",
    "StockCode": "stock_code",
    "Description": "description",
    "Quantity": "quantity",
    "InvoiceDate": "invoice_date",
    "Price": "price",
    "Customer ID": "customer_id",
    "Country": "country",
}


def get_engine():
    """ساخت engine اتصال به PostgreSQL از متغیرهای محیطی."""
    user = os.environ.get("DB_USER", "postgres")
    password = os.environ.get("DB_PASSWORD", "")
    host = os.environ.get("DB_HOST", "localhost")
    port = os.environ.get("DB_PORT", "5432")
    db_name = os.environ.get("DB_NAME", "retail_churn")

    url = f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{db_name}"
    return create_engine(url)


def find_raw_file() -> Path:
    """اولین فایل xlsx یا csv را در data/raw/ پیدا می‌کند."""
    candidates = list(RAW_DATA_DIR.glob("*.xlsx")) + list(RAW_DATA_DIR.glob("*.csv"))
    if not candidates:
        sys.exit(
            f"هیچ فایل xlsx/csv در {RAW_DATA_DIR} پیدا نشد. "
            "فایل دیتاست را دانلود و در این پوشه قرار بده."
        )
    return candidates[0]


def load_raw_dataframe(file_path: Path) -> pd.DataFrame:
    """
    فایل خام را می‌خواند. دیتاست اصلی UCI دو شیت اکسل دارد
    (Year 2009-2010 و Year 2010-2011) که اینجا با هم ترکیب می‌شوند.
    """
    if file_path.suffix == ".xlsx":
        sheets = pd.read_excel(file_path, sheet_name=None)
        df = pd.concat(sheets.values(), ignore_index=True)
    else:
        df = pd.read_csv(file_path, encoding="latin1")

    df = df.rename(columns=EXPECTED_COLUMNS)
    missing = set(EXPECTED_COLUMNS.values()) - set(df.columns)
    if missing:
        print(f"⚠️ هشدار: ستون‌های زیر پیدا نشدند: {missing}")

    return df


def main():
    raw_file = find_raw_file()
    print(f"در حال خواندن: {raw_file}")

    df = load_raw_dataframe(raw_file)
    print(f"تعداد رکورد خوانده‌شده: {len(df):,}")

    engine = get_engine()
    df.to_sql(TABLE_NAME, engine, if_exists="replace", index=False, chunksize=10_000)
    print(f"✅ داده‌ها در جدول '{TABLE_NAME}' بارگذاری شدند.")


if __name__ == "__main__":
    main()
