#!/bin/bash

# Load environment
# source /Users/poornima/Documents/secure/env-config-shopverse.sh

cd /Users/poornima/Documents/Idea/shopverse || exit

mkdir -p logs
rm -f shopverse_pids.txt

start_service() {
  local service_name=$1
  local service_log="logs/${service_name}.log"

  echo "Starting $service_name..."
  ./gradlew ":$service_name:bootRun" > "$service_log" 2>&1 &
  echo $! >> shopverse_pids.txt
}

start_service discovery-server
sleep 10

start_service config-server
sleep 10

start_service api-gateway
start_service user-service
start_service order-service
start_service product-service
start_service payment-service
start_service inventory-service
start_service notification-service
start_service analytic-service

echo "All services started. PIDs saved to shopverse_pids.txt"
