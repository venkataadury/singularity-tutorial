## Editable Images
Sometimes, environments need to be tweaked during the creation process and all steps to be executed will not be obvious at the time of build, so prescripted commands will not work.<br/>
For this reason, singularity allows the creation of *editable* images.

### Syntax
The `--sandbox` flag ensures that an image build by singularity is editable. The resulting image is much larger in size and is stored in an uncompressed folder instead of a compressed `.sif` file. 
Example (try in this directory):<br/>
`sudo singularity build --sandbox gromacs_editable base.def`<br/>
This will create a folder called `gromacs_editable` that has both the gromacs and plumed source codes at `/usr/software` (see def file to understand how this is done).<br/>
It can now be accessed via terminal in "writable" `-w` mode as follows:<br/>
`sudo singularity shell -w gromacs_editable`

### Compiling Plumed
Following the instructions from [here](https://www.plumed.org/doc-v2.10/user-doc/html/_installation.html), install plumed and patch gromacs as usual. For simplicity we will not enable mpi or all modules of plumed, but such complicated installs are perfect for singularity!<br/>
In the plumed, run:
```bash
./configure --prefix=/usr/software/plumed2.10
make -j 8
make install
```
Add /usr/software/plumed2.10/ related paths:
```bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/software/plumed2.10/lib/
export LIBRARY_PATH=$LIBRARY_PATH:/usr/software/plumed2.10/lib/
export PATH=$PATH:/usr/software/plumed2.10/bin/
```
Optionally, write a `sourceme.sh` file to automatically add all required paths.

### Patching GROMACS
1. Go to the gromacs folder `/usr/software/gromacs_src`
2. `plumed patch -p` (Pick the correct GROMACS Version - 2025.\*)
3. Make sure there are no errors

### Compiling GROMACS
Similar to the normal gromacs image, follow the following steps:
```bash
mkdir build && cd build
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DCMAKE_INSTALL_PREFIX=/usr/software/gromacs2025 -DGMX_GPU=CUDA -DGMX_MPI=off
make -j 12
make install
```
