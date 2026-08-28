#!/bin/bash
set -e

echo "=== Installing Docker on $(hostname) ==="


apt-get update -y

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


usermod -aG docker vagrant

systemctl enable docker
systemctl start docker

echo "=== Docker installed on $(hostname) ==="
docker --version