#!/bin/bash

echo "Stopping all services..."

if [ -f shopverse_pids.txt ]; then
  while read pid; do
    if kill -0 "$pid" 2>/dev/null; then
      kill -9 "$pid"
    fi
  done < shopverse_pids.txt

  rm -f shopverse_pids.txt
  echo "All services stopped and PID file deleted."
else
  echo "No PID file found. Nothing to stop."
fi
