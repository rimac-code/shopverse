#!/bin/bash

CONTAINER_NAME="shopverse-mysql"

if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "Container $CONTAINER_NAME already exists. Starting it..."
  docker start $CONTAINER_NAME
else
  echo "Creating and starting new MySQL container..."
  docker run -d \
    --name $CONTAINER_NAME \
    -e MYSQL_ROOT_PASSWORD=shopverse_root_pass \
    -e MYSQL_DATABASE=shopverse_db \
    -e MYSQL_USER=shopverse_user \
    -e MYSQL_PASSWORD=shopverse_pass \
    -p 3306:3306 \
    mysql:8.0
fi
