#!/bin/bash

pushd $SRC_DIR


TK_MAJOR_VERSION=${TK_VERSION%.*}

#this is needed to link vtk to TCL
export TK_LIB_NAME=libtk$TK_MAJOR_VERSION.so
export TK_EXE_NAME=wish$TK_MAJOR_VERSION
export TK_INSTALL_DIR=$INSTALL_DIR/tk-$TK_VERSION

if [[ $BUILD_TK -eq 1 ]]
then
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
fi

popd