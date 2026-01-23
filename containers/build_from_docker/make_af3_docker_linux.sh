#!/bin/bash

./install_docker.sh

# Build the AF3 docker image
sudo docker build . -t af3_docker -f docker/Dockerfile
sudo docker run -it af3_docker # Run docker image (for automatic setup)
cd ..
