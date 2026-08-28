#!/bin/bash
set -e

echo "=== Initializing Docker Swarm on $(hostname) ==="

MANAGER_IP=$(hostname -I | awk '{print $1}')
echo "Manager IP: $MANAGER_IP"

docker swarm init --advertise-addr $MANAGER_IP

echo ""
echo "=== Worker Join Token ==="
docker swarm join-token worker

echo ""
echo "=== Manager Join Token (если нужно добавить еще managers) ==="
docker swarm join-token manager

echo ""
echo "=== Swarm initialized on $(hostname) ==="
docker node ls