#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz

# extract source
tar -xf Python-$PYTHON_VERSION.tar.xz

# delete tar
rm Python-$PYTHON_VERSION.tar.xz

# create install directory 
mkdir -p $PYTHON_INSTALL_DIR
echo $PYTHON_INSTALL_DIR
# build and install
pushd Python-$PYTHON_VERSION

./configure --enable-shared --prefix=$PYTHON_INSTALL_DIR
make -j 4 && make install
popd

$PYTHON_INSTALL_DIR/bin/pip3 install numpy

popd
