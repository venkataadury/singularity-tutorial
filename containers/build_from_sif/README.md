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
