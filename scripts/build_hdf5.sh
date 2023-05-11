#!/bin/bash

pushd $SRC_DIR

# download tar 
HDF5_VERSION_="${HDF5_VERSION//./_}"
echo $HDF5_VERSION_
wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-$HDF5_VERSION_.tar.gz

# extract source
tar -xf hdf5-$HDF5_VERSION_.tar.gz

# delete tar
rm hdf5-$HDF5_VERSION_.tar.gz
mv hdf5-hdf5-$HDF5_VERSION_ hdf5-$HDF5_VERSION

# create install directory 
mkdir -p $HDF5_INSTALL_DIR

# build and install
pushd hdf5-$HDF5_VERSION
mkdir -p build && cd build
cmake \
    -DHDF5_BUILD_SHARED_LIBS=1 \
    -DHDF5_BUILD_HL_LIB:BOOL=ON \
    -DHDF5_BUILD_CPP_LIB:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX=$HDF5_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
..
make -j 4
make install
popd

popd
