#!/bin/bash

echo "Stopping all services..."

if [ ! -f shopverse_pids.txt ]; then
  echo "⚠️ No PID file found. Nothing to stop."
  exit 0
fi

while read pid; do
  if kill -0 $pid 2>/dev/null; then
    echo "Killing process $pid"
    kill -9 $pid
  else
    echo "PID $pid is not running"
  fi
done < shopverse_pids.txt

rm shopverse_pids.txt
echo "🛑 All services stopped."
