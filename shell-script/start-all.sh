#!/bin/bash

echo "🔨 Building all services..."
cd .. || exit 1
./gradlew clean build -x test || exit 1
cd shell-script || exit 1

rm -f shopverse_pids.txt

echo "🚀 Starting discovery-server..."
DISCOVERY_JAR=$(find ../discovery-server/build/libs -name '*SNAPSHOT.jar' ! -name '*plain.jar' | head -n 1)
nohup java -jar "$DISCOVERY_JAR" > ../discovery-server/log.txt 2>&1 &
echo $! >> shopverse_pids.txt
sleep 5

echo "🚀 Starting config-server..."
CONFIG_JAR=$(find ../config-server/build/libs -name '*SNAPSHOT.jar' ! -name '*plain.jar' | head -n 1)
nohup java -jar "$CONFIG_JAR" > ../config-server/log.txt 2>&1 &
echo $! >> shopverse_pids.txt

# 🩺 Wait for Config Server to be UP
echo "🩺 Waiting for Config Server at http://localhost:8888..."
until curl -s http://localhost:8888/actuator/health | grep -q '"status":"UP"'; do
  echo "⏳ Still waiting for Config Server..."
  sleep 2
done
echo "✅ Config Server is UP!"

# 🧠 All services that depend on config-server
SERVICES=(
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
  echo "👉 Starting $service..."
  JAR_PATH=$(find ../$service/build/libs -name '*SNAPSHOT.jar' ! -name '*plain.jar' | head -n 1)

  if [ -f "$JAR_PATH" ]; then
    nohup java \
      -Dspring.profiles.active=default \
      -Dspring.config.import=optional:configserver:http://localhost:8888 \
      -jar "$JAR_PATH" > "../$service/log.txt" 2>&1 &
    echo $! >> shopverse_pids.txt
    echo "✅ $service started with PID $!"
  else
    echo "❌ JAR not found for $service. Skipping..."
  fi
done

# 🩺 Wait for Eureka (optional)
echo "🩺 Waiting for Eureka at http://localhost:8761..."
until curl -s http://localhost:8761 | grep -q "Instances currently registered"; do
  echo "⏳ Still waiting for Eureka..."
  sleep 2
done
echo "✅ Eureka is up!"

echo "🏁 All startup attempts finished. Check 'shopverse_pids.txt' and individual log files for details."
