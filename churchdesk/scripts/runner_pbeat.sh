#!/bin/sh

# Start the first process
echo 'Packetbeat starting';
nohup ./packetbeat/packetbeat -c ${PACKETBEAT_CONFIG} &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start packetbeat: $status"
  exit $status
fi

# Start traefik
echo "Start traefik"
nohup traefik &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start traefik: $status"
  exit $status
fi

# Give the process a chance to start.
sleep 3

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container will exit with an error
# if it detects that either of the processes has exited.
# Otherwise it will loop forever, waking up every 60 seconds
while /bin/true; do
  ps aux |grep packetbeat |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep traefik |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "Packetbeat has already exited."
    exit 1
  fi
  if [ $PROCESS_2_STATUS -ne 0 ]; then
    echo "Traefik has already exited."
    exit 1
  fi
  sleep 60
done