#!/usr/bin/env bash

# Start snapclient if multi room is enabled
if [[ -z $DISABLE_MULTI_ROOM ]]; then
  # Wait for fleet-supervisor to start up
  # We need this because fleet-supervisor depends on resin_supervisor, which has no support for depends_on
  while ! curl -s "http://115.73.222.253:3000"; do sleep 1; done

  # Add latency if defined to compensate for speaker hardware sync issues
  if [[ -n $DEVICE_LATENCY ]]; then
    LATENCY="--latency $DEVICE_LATENCY"
  fi

  # Start snapclient
  SNAPCAST_SERVER="115.73.222.253"
  echo -e "Starting snapclient...\nTarget snapcast server: $SNAPCAST_SERVER"
  snapclient -h $SNAPCAST_SERVER $LATENCY
else
  echo "Multi-room audio is disabled, not starting snapclient."
  exit 0
fi
