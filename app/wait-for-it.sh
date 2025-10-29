#!/usr/bin/env bash
# wait-for-it.sh — ждёт доступности TCP порта
# Usage: ./wait-for-it.sh host:port [-t timeout] [-- command args]

set -e

host="$1"
port="$2"
shift 2
cmd="$@"

until nc -z "$host" "$port"; do
  echo "Ожидание сервиса $host:$port..."
  sleep 2
done

echo "Сервис $host:$port доступен, запускаем команду..."
exec $cmd
