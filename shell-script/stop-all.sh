#!/bin/bash

if [ ! -f shopverse_pids.txt ]; then
  echo "❌ No shopverse_pids.txt found. Nothing to stop."
  exit 1
fi

echo "🛑 Stopping all Shopverse services..."

while read pid; do
  if kill "$pid" 2>/dev/null; then
    echo "🔴 Stopped process $pid"
  else
    echo "⚠️ Could not stop process $pid (may already be dead)"
  fi
done < shopverse_pids.txt

rm -f shopverse_pids.txt
echo "✅ All services stopped and PID file removed."
