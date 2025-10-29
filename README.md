Junior backend разработчик

## Технологии
- Python 3.12
- PostgreSQL 15
- Docker & Docker Compose
- psycopg2, pandas
- SQLAlchemy (опционально)

## Структура проекта
```bash
app/
├── config.py # Конфигурация подключения к БД
├── main.py # Основной скрипт
├── models/
│ └── db.py # Работа с подключением к БД
├── Dockerfile
└── requirements.txt
.env.example # Пример файла окружен
```

## Запуск через Docker

1. Создайте файл .env на основе .env.example:

```bash
cp app/.env.example app/.env
```

2. Запустите контейнер
```bash
docker-compose up --build
```
3. Сервис приложения будет доступен после поднятия контейнеров, скрипт автоматически подключается к базе и выполняет запросы.
