#!/bin/bash
set -e

MANAGER_IP="192.168.56.10"
WORKER_TOKEN="SWMTKN-1-твой-токен-от-manager"

echo "=== Joining Docker Swarm on $(hostname) ==="
echo "Manager: $MANAGER_IP"

docker swarm join --token $WORKER_TOKEN $MANAGER_IP:2377

echo ""
echo "=== Joined Swarm on $(hostname) ==="