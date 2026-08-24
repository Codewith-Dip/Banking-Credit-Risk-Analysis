import pandas as pd
import mysql.connector
from getpass import getpass

# -----------------------------------
# 1. CSV FILE
# -----------------------------------

csv_file = r"D:\Projects\Banking-credit-risk- analysis\data\cleaned_loan_data.csv"


# -----------------------------------
# 2. MYSQL CONNECTION
# -----------------------------------

password = getpass("Enter MySQL password: ")

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=password,
    database="banking_credit_risk"
)

cursor = conn.cursor()

print("Connected to MySQL successfully!")


# -----------------------------------
# 3. CLEAR OLD DATA
# -----------------------------------

cursor.execute("TRUNCATE TABLE loans")
conn.commit()

print("Existing table data cleared.")


# -----------------------------------
# 4. INSERT QUERY
# -----------------------------------

insert_query = """
INSERT INTO loans (
    id,
    issue_d,
    issue_date,
    issue_year,
    revenue,
    dti_n,
    loan_amnt,
    fico_n,
    experience_c,
    emp_length,
    purpose,
    addr_state,
    home_ownership_n,
    zip_code,
    `Default`,
    risk_category
)
VALUES (
    %s, %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s, %s, %s
)
"""


# -----------------------------------
# 5. READ CSV IN CHUNKS
# -----------------------------------

chunk_size = 5000
total_rows = 0

for chunk in pd.read_csv(csv_file, chunksize=chunk_size):

    # Properly convert NaN to Python None
    chunk = chunk.astype(object).where(pd.notnull(chunk), None)

    # Convert date
    chunk["issue_date"] = pd.to_datetime(
        chunk["issue_date"],
        errors="coerce"
    ).dt.date

    data = list(
        chunk[
            [
                "id",
                "issue_d",
                "issue_date",
                "issue_year",
                "revenue",
                "dti_n",
                "loan_amnt",
                "fico_n",
                "experience_c",
                "emp_length",
                "purpose",
                "addr_state",
                "home_ownership_n",
                "zip_code",
                "Default",
                "risk_category"
            ]
        ].itertuples(index=False, name=None)
    )

    cursor.executemany(insert_query, data)
    conn.commit()

    total_rows += len(data)

    print(f"Inserted {total_rows:,} rows...")


# -----------------------------------
# 6. VERIFY
# -----------------------------------

cursor.execute("SELECT COUNT(*) FROM loans")

count = cursor.fetchone()[0]

print("\n==============================")
print("IMPORT COMPLETED")
print("==============================")
print(f"Rows inserted: {count:,}")


# -----------------------------------
# 7. CLOSE
# -----------------------------------

cursor.close()
conn.close()

print("MySQL connection closed.")