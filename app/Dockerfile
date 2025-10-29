FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем netcat корректно
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

COPY . .

# Делаем скрипт wait-for-it.sh исполняемым
RUN chmod +x wait-for-it.sh

# Запуск приложения через wait-for-it.sh
CMD ["./wait-for-it.sh", "db", "5432", "--", "python", "main.py"]
