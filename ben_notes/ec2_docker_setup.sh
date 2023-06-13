#!/usr/bin/env bash

set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    unzip

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker ubuntu

GITHUB_DIR=/home/ubuntu/github
mkdir ${GITHUB_DIR} && cd ${GITHUB_DIR}
git clone https://github.com/davetang/learning_docker.git
sudo chown -R ubuntu:ubuntu ${GITHUB_DIR}

>&2 echo Setup complete. Please logout and login again.
exit 0
