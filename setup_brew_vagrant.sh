#!/bin/bash

brew help 1> /dev/null 2> /dev/null
if test $? -eq 0
then
	echo "Homebrew for Mac detected. Skipping install"
else
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install --cask virtualbox && brew install --cask vagrant && brew install --cask vagrant-manager
if test $? -ne 0
then
	echo "brew failed."
	exit 1
fi
echo "Done. 'brew' is installed"

# Vagrant setup
mkdir vm-singularity && cd vm-singularity
export VM=bento/ubuntu-22.04 && vagrant init $VM && vagrant up
if test $? -ne 0
then
	echo "Vagrant installation failed. Is the VM '$VM' still available?"
	exit 1
fi
vagrant plugin install vagrant-scp
echo "Vagrant set up"

# Copy over the setup file
sed s/"ARCH=amd64"/"ARCH=arm64"/ ../setup_linux.sh > ../setup.sh
chmod +x ../setup.sh
vagrant scp ../setup.sh /home/vagrant

# Start the VM
echo
echo "**********************************"
echo "Starting shell. Now run ./setup.sh"
echo "**********************************"
echo
vagrant ssh

