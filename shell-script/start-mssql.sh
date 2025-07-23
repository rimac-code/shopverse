#!/bin/bash

CONTAINER_NAME=shopverse-mssql

# Check if container exists
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME already exists. Starting it..."
    docker start $CONTAINER_NAME
else
    echo "Creating and starting new MSSQL container..."
    docker run -e "ACCEPT_EULA=Y" \
               -e "MSSQL_SA_PASSWORD=M0nal1sa" \
               -p 1433:1433 \
               --name $CONTAINER_NAME \
               -d mcr.microsoft.com/mssql/server:2022-latest
fi
