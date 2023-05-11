#!/bin/bash

pushd $SRC_DIR

# download tar 
QT_MAJOR_VERSION=${QT_VERSION%.*}
wget https://download.qt.io/archive/qt/$QT_MAJOR_VERSION/$QT_VERSION/single/qt-everywhere-src-$QT_VERSION.tar.xz

# extract source
tar -xf qt-everywhere-src-$QT_VERSION.tar.xz

# delete tar
rm qt-everywhere-src-$QT_VERSION.tar.xz

# create install directory 
mkdir -p $QT_INSTALL_DIR

# apply patch 
# build and install
pushd qt-everywhere-src-$QT_VERSION
./configure -opensource -confirm-license --prefix=$QT_INSTALL_DIR -v 
patch -p1 < $PATCH_DIR/qt-$QT_VERSION-clang.patch
make -j 8
make install
popd

popd

# create tar
cd install
tar -cf qt.tar qt-$QT_VERSION
cd ..
