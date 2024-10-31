#!/bin/bash

CR_NAME="$1"

# Ищем все контейнеры, начинающиеся с этого префикса и заканчивающиеся числом
for container in $(docker ps --filter "name=${CR_NAME}" --format "{{.Names}}"); do
    # Проверяем, что имя контейнера заканчивается на число
    if [[ $container =~ ^${CR_NAME}-[0-9]+$ ]]; then
        echo "Перезапускаем контейнер: $container"
        docker-compose -f ~/space21/staging/staging-deployment/docker-compose.yml \
                    --env-file ~/space21/staging/.env up -d $container
    else
        echo "Пропускаем контейнер: $container"
    fi
done