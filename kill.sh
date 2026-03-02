#!/bin/bash

PID=$(lsof -ti :5174)

if [ -z "$PID" ]; then
  echo "No process found on port 5174."
else
  echo "Killing process $PID on port 5174..."
  kill -9 $PID
  echo "Done."
fi

