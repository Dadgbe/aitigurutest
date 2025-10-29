from models.db import get_connection

def main():
    conn = get_connection()
    if conn:
        cur = conn.cursor()
        cur.execute("SELECT version();")
        print("Версия PostgreSQL:", cur.fetchone())
        cur.close()
        conn.close()
    else:
        print("Не удалось подключиться к БД")

if __name__ == "__main__":
    main()
