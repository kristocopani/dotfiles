#!/bin/bash
apt-get update -qq -y > /dev/null && apt-get upgrade -q -y
apt-get install ca-certificates curl gnupg lsb-release -y -q > /dev/null
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -qq -y > /dev/null && apt-get upgrade -q -y
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y -q > /dev/null
usermod -aG docker "${USER}"
systemctl enable docker &&  systemctl start docker
USERNAME="Christos Copani"
EMAIL="kristocopani@gmail.com"
git config --global user.email $USERNAME
git config --global user.name $EMAIL
