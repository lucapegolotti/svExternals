#!/bin/bash

pushd $SRC_DIR

# download tar 
wget  https://downloads.sourceforge.net/tcl/tk$TK_VERSION-src.tar.gz

# extract source
tar -xf tk$TK_VERSION-src.tar.gz

# delete tar
rm tk$TCL_VERSION-src.tar.gz

# create install directory 
mkdir -p $TK_INSTALL_DIR

# build and install
pushd tk$TK_VERSION/unix
./configure --prefix=$TK_INSTALL_DIR
make -j 2 install
popd

popd