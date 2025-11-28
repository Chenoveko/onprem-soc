#!/bin/bash
#==========Install Docker on Ubuntu using the apt repository==========#
# 1º) Set up Docker's apt repository.
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

# 2º) Install the Docker packages.
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify that Docker is running -> sudo systemctl status docker
# Verify that the installation is successful -> sudo docker run hello-world

# 3º) Linux post-installation steps for Docker Engine
# Create the docker group
sudo groupadd docker
# Add your user to the docker group
sudo usermod -aG docker $USER
# Activate the changes to groups
newgrp docker   

# Verify that you can run docker commands without sudo -> docker run hello-world