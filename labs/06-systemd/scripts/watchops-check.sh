#!/usr/bin/env bash

echo "$(date -Iseconds) WatchOos scheduled check"
systemctl is-active watchops-stub.service
