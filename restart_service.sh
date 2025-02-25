#!/bin/bash

# Check if a service name was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name> [<logger_name>]"
  exit 1
fi

SERVICE_NAME=$1
LOGGER_NAME=${2:-"default"}

# Restart the service
logger -t $LOGGER_NAME "Restarting $SERVICE_NAME"
sudo service $SERVICE_NAME restart

# Wait for 2 minutes
sleep 120

# Attempt to start the service up to 5 times if it's not running
attempts=0
while [ $attempts -lt 5 ]; do
  status=$(sudo service $SERVICE_NAME status | grep 'active (running)')
  if [ -z "$status" ]; then
    logger -t $LOGGER_NAME "Attempt $(($attempts + 1)): $SERVICE_NAME is not running. Trying to start it."
    sudo service $SERVICE_NAME start
    sleep 120
    attempts=$(($attempts + 1))
  else
    logger -t $LOGGER_NAME "$SERVICE_NAME is running fine."
    break
  fi
done

if [ $attempts -eq 5 ]; then
  logger -t $LOGGER_NAME "Failed to start $SERVICE_NAME after 5 attempts."
fi
