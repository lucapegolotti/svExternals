#!/bin/bash

pushd $SRC_DIR

# download tar 
wget  https://sourceforge.net/projects/tcl/files/Tcl/$TCL_VERSION/tcl$TCL_VERSION-src.tar.gz

# extract source
tar -xf tcl$TCL_VERSION-src.tar.gz

# delete tar
rm tcl$TCL_VERSION-src.tar.gz

# create install directory 
mkdir -p $TCL_INSTALL_DIR

# build and install
if [[ "$(uname)" == 'Linux' ]]; then
    pushd tcl$TCL_VERSION/unix
elif [[ "$(uname)" == 'Darwin' ]]; then
    pushd tcl$TCL_VERSION/macosx
fi
./configure --prefix=$TCL_INSTALL_DIR  --exec-prefix=$TCL_INSTALL_DIR
make -j 2 install
popd

popd

# mkdir -p tar

# # create tar
# cd install
# tar -cf tcl.tar tcl-$TCL_VERSION
# cd ..