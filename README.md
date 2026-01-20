# About (Containers & Singularity)
Using the singularity container environment - Compile once, run anywhere. Leverage the power of containerization to seamlessly move software between systems.
Singularity is one such software, designed to run natively only on a linux kernel. Singularity is [open source](https://github.com/sylabs/singularity) and can be compiled using [go](https://go.dev)

# What are containers?
Containers are encapsulating environments (similar to virtual environments created by miniconda for python), but are more extensive containing the entire base operating system files as well. As a result, programs packaged in a container do not depend on the parent computer's library or previous software installations for anything. This means copying a container over to a new system is all that is required to transfer even the most complex of programs

## Advantages
- Fast: After launching, programs running within a container run as fast as any other
- Reliable: If a program works once, it will always work. No system upgrades or local package modifications will break it!
- Transferable: Can be moved seamlessly between systems without requiring each system to have any other prerequisites installed
- Accessible: Specifically for singularity, no admin privilages are needed to run a container. Copy and run!
See more [here](https://docs.sylabs.io/guides/3.7/user-guide/introduction.html#use-cases)!

## Downsides
- Size on disk: Container contain a snapshot of the bas operating system. Even when compressed, this makes each container several GB in size.
- Not (easily) editable: Once made, modifying the files (though possible) is slow and inefficient. You can write new file (i.e. like when MD software writes a trajectory) but cannot edit existing internal files that belong to the software.
- No caching: Specifically for singularity, no snapshots of the container building process are made. This means that any failure *while building* requires us to start over

# Why singularity?
There are many other containerization methods [docker](https://www.docker.com) being the most famous one. Docker requires both the making of a container and its execution to be done with *admin privilages* which is not possible when working on remote servers.<br/>
Since singularity requires admin privilages only for *making* the container, it can be made locally once, and copied over to any server. 

# When to consider making a container?
Given the immense size and time taken to build each container, they cannot be used for everything. A few scenarios that would benefit from containerization are:
1. Convoluted dependencies: This is the primary reason to use containers. Do you find a bunch of annoying package version selections you need to keep forcing for your package to work (e.g. some python libraries)?
2. Mutually incompatible software: Did you have cases where library 1 requires python>=3.11 and library 2 requires python<3.8 ??? Put one of them in a container! However, since containers take up a lot of space, partition you libraries to have the minimum number of containers.
3. Experimenting with requirements: If you don't know what exact requirements a package has and do not want to mess up you local system packages, containers provide a convienient playground that will not affect your base system. If you ruin you container, just delete and start again! 
4. Old software: Very old software that uses deprecated or very antequated libraries benefit from containerization as they are usually much smaller and will not break with future system updates

# Installation
As discussed, singularity runs natively on linux. This library provides solutions to run singularity on linux computers and Macbooks (Apple Silicon). If you are using a windows PC, follow [this](https://docs.sylabs.io/guides/3.0/user-guide/installation.html#setup). It is very similar to Mac, except it uses the default AMD64 architecture instead of ARM64 (check your computer's chipset).

## On linux
See [this link](https://docs.sylabs.io/guides/3.0/user-guide/installation.html#install-on-linux) on the original website for more information. Here, `setup_linux.sh` is designed for ubuntu systems. If you use a different distribution, use your own package manager to install the dependences highlighted in this script, and continue the same steps as in this script after.<br/>
If you are using **Ubuntu>=22.04, just run** `./setup_linux.sh` and enter your password when prompted (installation requires admin privilages)

## On Apple Silicon (Macbook)
Since singularity only runs on linux kernels, we will emulate linux on macbooks through [VirtualBox](https://www.virtualbox.org). This also requires admin privilages to install.<br/>
The following software will be installed by the setup script provided.
- [Homebrew](https://brew.sh): Install 3rd party software easily on Mac
- [Vagrant](https://developer.hashicorp.com/vagrant): A Virtual Machine manager. This is what manages our linux emulation.
Note that though these packages may break with time, and containers built with singularity will still run on any other linux PC.

The script will then download [Ubuntu for ARM](https://ubuntu.com/download/server/arm) from the vagrant library at [bento/ubuntu-22.04](https://portal.cloud.hashicorp.com/vagrant/discover/bento/ubuntu-22.04) which is a special version of Ubuntu compatible with Apple Silicon.<br/>
We will then go on to install singularity inside this ubuntu virtual machine using the same method as above.

**To start just run**: `./setup_brew_vagrant.sh` on your apple computer.
