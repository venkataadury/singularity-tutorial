#!/bin/bash
#
# For linux
sudo singularity build alphafold3_singularity.sif docker-daemon://af3_docker:latest

# For macbook (build directly from link - no download)
sudo singularity build alphafold3.sif docker://jurgjn/alphafold3:v3.0.1-daint1 # ARM64 alphafold3
