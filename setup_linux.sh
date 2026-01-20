#!/bin/bash

export ARCH=amd64
#export ARCH=amd64 # For most computers
#export ARCH=arm64 # For Apple Silicon

#Dependencies
sudo apt-get update && sudo apt-get install -y build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev pkg-config

# Install Go (installation protocol)
export VERSION=1.17 OS=linux && wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz

export GOPATH=${HOME}/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
rm go$VERSION.$OS-$ARCH.tar.gz # Cleanup

# Download singularity Open Source Code
mkdir -p $GOPATH/src/github.com/sylabs && cd $GOPATH/src/github.com/sylabs && rm -f singularity-ce-3.9.8.tar.gz && wget https://github.com/sylabs/singularity/releases/download/v3.9.8/singularity-ce-3.9.8.tar.gz && tar -xzf singularity-ce-3.9.8.tar.gz && rm singularity-ce-3.9.8.tar.gz
if test $? -ne 0
then
	echo "ERR: Couldn't download/extract tar file. Are the release version and github source path correct?"
	exit 1
fi
mv singularity-ce-3.9.8 singularity && cd singularity
./mconfig
if test $? -eq 0
then
	echo "Configure was successful. Building"
else
	echo "ERR: Configuration failed. Did you pick the correct architecture (see the 'ARCH' variable at the top of this script)?"
	exit 1
fi

cd $GOPATH/src/github.com/sylabs/singularity/builddir/
make -j 4 && sudo make install
if test $? -eq 0
then
	echo "Seems like the install was successful. Testing"
	singularity
else
	echo "Make or make install encountered an error"
	exit 1
fi
