# main.py
import pandas as pd
from models.db import get_connection

# запрос: сумма товаров по клиентам
query_clients = """
SELECT
  c.id AS client_id,
  c.name AS client_name,
  COALESCE(SUM(oi.quantity * oi.unit_price), 0)::NUMERIC(14,2) AS total_sum
FROM clients c
LEFT JOIN orders o ON o.client_id = c.id
LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id, c.name
ORDER BY total_sum DESC;
"""

# Запрос: количество дочерних категорий
query_categories = """
SELECT
  parent.id   AS category_id,
  parent.name AS category_name,
  COUNT(child.id) AS children_count
FROM categories parent
LEFT JOIN categories child ON child.parent_id = parent.id
GROUP BY parent.id, parent.name
ORDER BY parent.name;
"""

def run_query(query, description):
    print(f"\n--- {description} ---")
    conn = get_connection()
    if conn is None:
        print("Нет подключения к базе данных")
        return
    try:
        df = pd.read_sql_query(query, conn)
        print(df)
    except Exception as e:
        print(f"Ошибка выполнения запроса: {e}")
    finally:
        conn.close()

if __name__ == "__main__":
    run_query(query_clients, "Сумма товаров по клиентам")
    run_query(query_categories, "Количество дочерних категорий")