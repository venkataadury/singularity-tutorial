#!/bin/bash
#
# Remember the tag used for docker image (af3_docker by default)
# 1. Save the docker container to a local tar file
sudo docker save af3_docker:latest -o af3_docker.tar

# 2. Use local tar file to make singularity image
sudo singularity build alphafold3_singularity.sif af3_docker.tar

# 3. Cleanup - Delete the temporary tar file
sudo rm -f af3_docker.tar 
