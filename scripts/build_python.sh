#!/bin/bash

pushd $SRC_DIR

export PYTHON_EXECUTABLE=bin/python3
export PYTHON_INCLUDE_DIR=include/python3.9
export PYTHON_LIBRARY=lib/libpython3.9.a
export PYTHON_INSTALL_DIR=$INSTALL_DIR/python-$PYTHON_VERSION

if [[ $BUILD_PYTHON -eq 1 ]]
then
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
    ./configure --prefix=$PYTHON_INSTALL_DIR
    make -j 4 && make install
    popd

    $PYTHON_INSTALL_DIR/bin/pip3 install numpy
fi

popd
