#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://github.com/MmgTools/mmg/archive/refs/tags/v$MMG_VERSION.tar.gz

# extract source
tar -xf v$MMG_VERSION.tar.gz

# delete tar
rm v$MMG_VERSION.tar.gz

# create install directory 
mkdir -p $MMG_INSTALL_DIR
echo $MMG_INSTALL_DIR
# build and install
pushd mmg-$MMG_VERSION
mkdir -p build && cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=$MMG_INSTALL_DIR \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DLIBMMG2D_SHARED=0 \
    -DLIBMMG3D_SHARED=0 \
    -DLIBMMGS_SHARED=0 \
    -DLIBMMG_SHARED=0 \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j 2 && make install
popd

popd

# create tar
cd install
tar -cf mmg.tar mmg-$MMG_VERSION
cd ..

