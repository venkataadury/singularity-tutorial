#!/bin/bash

# Clone the Repo
git clone --recurse-submodules "https://github.com/google-deepmind/alphafold3.git"
cd alphafold3
if test $? -ne 0
then
	echo "Clone failed?"
	exit 1
fi

# From Alphafold3 installation instructions (https://github.com/google-deepmind/alphafold3/blob/main/docs/installation.md)
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Install the specific docker version required by Alphafold
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

cd ..
