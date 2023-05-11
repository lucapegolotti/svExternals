#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://github.com/leethomason/tinyxml2/archive/refs/tags/$TINYXML2_VERSION.tar.gz

# extract source
tar -xf $TINYXML2_VERSION.tar.gz

# delete tar
rm $TINYXML2_VERSION.tar.gz

# create install directory 
mkdir -p $TINYXML2_INSTALL_DIR

# build and install
pushd tinyxml2-$TINYXML2_VERSION
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$TINYXML2_INSTALL_DIR ..
make -j 4 && make install
popd

popd

# create tar
cd install
tar -cf tinyxml2.tar tinyxml2-$TINYXML2_VERSION
cd ..
