#!/bin/bash

# Clean old PID file if it exists
rm -f shopverse_pids.txt

echo "Starting all services..."

SERVICES=(
  "discovery-server"
  "config-server"
  "api-gateway"
  "user-service"
  "order-service"
  "product-service"
  "payment-service"
  "inventory-service"
  "notification-service"
  "analytic-service"
)

for service in "${SERVICES[@]}"
do
  echo "Starting $service..."
  nohup java -jar ../$service/build/libs/$service-*.jar > ../$service/log.txt 2>&1 &
  PID=$!
  echo "$PID" >> shopverse_pids.txt
  echo "$service started with PID $PID"
done

echo "✅ All services started. PIDs saved to shopverse_pids.txt"
