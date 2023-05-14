#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://github.com/swig/swig/archive/refs/tags/v$SWIG_VERSION.tar.gz

# extract source
tar -xf v$SWIG_VERSION.tar.gz

# delete tar
rm v$SWIG_VERSION.tar.gz

# create install directory 
mkdir -p $SWIG_INSTALL_DIR
echo $SWIG_INSTALL_DIR
# build and install
pushd swig-$SWIG_VERSION
source autogen.sh # need automake for Mac (brew install automake)
cd ..
./configure --prefix=$SWIG_INSTALL_DIR
make -j 2
make install
popd

popd

# create tar
cd install
tar -cf swig.tar swig-$SWIG_VERSION
cd ..
