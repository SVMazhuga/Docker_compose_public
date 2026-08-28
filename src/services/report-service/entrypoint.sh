#!/bin/bash 

set -e 

if [ -n "$POSTGRES_HOST" ]; then
    /app/wait-for-it.sh "${POSTGRES_HOST}:${POSTGRES_PORT}" \
    --timeout=60 \
    --strict \
    --
fi 

if [ -n "$RABBITMQ_HOST" ]; then
    /app/wait-for-it.sh "${RABBITMQ_HOST}:${RABBITMQ_PORT}" \
    --timeout=60 \
    --strict \
    --
fi 

exec "$@"