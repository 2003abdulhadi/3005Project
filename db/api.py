import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connection parameters
conn_params = {
    "dbname": "postgres",  # connect to default database to check/create our target database
    "user": "emkm9",
    "password": "password",
    "host": "localhost",
}


def create_database():
    conn = connect_to_default_db()
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute("SELECT 1 FROM pg_catalog.pg_database WHERE datname = 'fitness_db'")
    exists = cur.fetchone()
    if not exists:
        cur.execute("CREATE DATABASE fitness_db")
        print("Database 'fitness_db' created successfully.")
    cur.close()
    conn.close()


def drop_database():
    conn = connect_to_default_db()
    if conn:
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        try:
            cur = conn.cursor()
            cur.execute("DROP DATABASE IF EXISTS fitness_db")
            print("Database 'fitness_db' dropped successfully.")
            cur.close()
        except psycopg2.Error as e:
            print(f"Error dropping the database: {e}")
        finally:
            conn.close()


def connect_to_default_db():
    try:
        conn = psycopg2.connect(**conn_params)
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to the default database: {e}")
        return None


def connect_to_db():
    db_params = conn_params.copy()
    db_params["dbname"] = "fitness_db"
    try:
        conn = psycopg2.connect(**db_params)
        conn.autocommit = True
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to 'fitness_db': {e}")
        return None


def is_database_empty(conn):
    """Check if the database is empty by verifying each table has no data."""
    cur = conn.cursor()
    cur.execute(
        "SELECT table_name FROM information_schema.tables "
        "WHERE table_schema = 'public' AND table_type = 'BASE TABLE';"
    )
    tables = cur.fetchall()
    if not tables:
        return True  # No tables, database is definitely empty

    for (table,) in tables:
        cur.execute(f"SELECT EXISTS (SELECT 1 FROM {table} LIMIT 1);")
        if cur.fetchone()[0]:
            return False  # Found a table with data, database is not empty

    return True  # No data found in any table


def load_sample_data(conn, filepath):
    with conn.cursor() as cur:
        with open(filepath, "r") as file:
            cur.execute(file.read())


def create_tables_from_schema(conn, filepath):
    
    with conn.cursor() as cur:
        with open(filepath, "r") as file:
            cur.execute(file.read())



def query_all_tables(conn):
    if conn is not None:
        try:
            cur = conn.cursor()
            cur.execute(
                """
                SELECT table_name FROM information_schema.tables
                WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
                """
            )
            tables = cur.fetchall()
            for (table,) in tables:
                print(f"Querying contents of table: {table}")
                cur.execute(f"SELECT * FROM {table};")
                rows = cur.fetchall()
                if rows:
                    print(f"Contents of {table}:")
                    for row in rows:
                        print(row)
                else:
                    print(f"{table} is empty.")
            cur.close()
        except psycopg2.Error as e:
            print(f"An error occurred: {e}")
    else:
        print("Connection to the database is not established.")


def main():
    drop_database()  # Drop the existing database to start fresh
    create_database()
    conn = connect_to_db()
    if conn is not None:
        if is_database_empty(conn):
            print("Database is empty. Creating tables...")
            create_tables_from_schema(conn, "schema.sql")
            print("Loading sample data...")
            load_sample_data(conn, "sample_data.sql")
        else:
            print("Database is already populated.")
        query_all_tables(conn)  # Moved outside of the 'if' to ensure it runs regardless
        conn.close()
    else:
        print("Unable to connect to the database.")


if __name__ == "__main__":
    main()
