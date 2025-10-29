FROM python:3.12-slim

# Устанавливаем системные зависимости для psycopg2 и netcat
RUN apt-get update && \
    apt-get install -y netcat-openbsd gcc libpq-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Делаем скрипт wait-for-it.sh исполняемым
RUN chmod +x wait-for-it.sh

# Запуск приложения через wait-for-it.sh
CMD ["./wait-for-it.sh", "db", "5432", "--", "python", "main.py"]
