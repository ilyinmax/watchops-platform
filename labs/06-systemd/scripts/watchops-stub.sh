#!/usr/bin/env bash

echo "WatchOps stub started, PID=$$, interval=${WATCHOPS_INTERVAL}s"

while true; do
    echo "$(date -Iseconds) WatchOps heartbeat"
    sleep "$WATCHOPS_INTERVAL"
done
