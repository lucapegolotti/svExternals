#!/bin/bash

pushd $SRC_DIR

# download tar 
QT_MAJOR_VERSION=${QT_VERSION%.*}
wget https://download.qt.io/archive/qt/$QT_MAJOR_VERSION/$QT_VERSION/single/qt-everywhere-opensource-src-$QT_VERSION.tar.xz

# extract source
tar -xf qt-everywhere-opensource-src-$QT_VERSION.tar.xz

# delete tar
rm qt-everywhere-opensource-src-$QT_VERSION.tar.xz

# create install directory 
mkdir -p $QT_INSTALL_DIR

# apply patch 
# build and install
pushd qt-everywhere-src-$QT_VERSION
./configure -opensource -confirm-license --prefix=$QT_INSTALL_DIR -release -nomake examples -nomake tests -opengl desktop -skip qtconnectivity -skip qtdoc -skip qtsensors -skip qtgamepad -skip qtlocation -skip qtspeech -skip qtscxml -skip qtremoteobjects -skip qtquickcontrols -skip qtquickcontrols2 -skip qtmacextras -skip qtlottie -skip qtserialbus -skip qttranslations
patch -p1 < $PATCH_DIR/qt-$QT_VERSION-clang.patch

if [[ $(uname) == 'Linux' ]]; then 
    make -j 4
elif [[ $(uname) == 'Darwin' ]]; then 
    # in mac there might be a race condition so we use one processor
    make -j 1
fi
make install
popd

popd

# create tar
cd install
tar -cf qt.tar qt-$QT_VERSION
cd ..
