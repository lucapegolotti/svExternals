#!/bin/bash

pushd $SRC_DIR

# download tar 
OPENCASCADE_MAJOR_VERSION=${OPENCASCADE_VERSION%.*}
# for now we need to download from tetra because the official site requires
# a login
wget http://simvascular.stanford.edu/downloads/public/simvascular/externals/2022.10/src/originals/opencascade/opencascade-$OPENCASCADE_VERSION.tar


# extract source
tar -xf opencascade-$OPENCASCADE_VERSION.tar

# delete tar
rm opencascade-$OPENCASCADE_VERSION.tar

# create install directory 
mkdir -p $OPENCASCADE_INSTALL_DIR

pushd opencascade-$OPENCASCADE_VERSION
mkdir -p build
cd build

# removed options like these:
# -D3RDPARTY_FREETYPE_DLL:FILEPATH=REPLACEME_SV_TOP_BIN_DIR_FREETYPE/lib/REPLACEME_SV_FREETYPE_LIBRARY \
# maybe needed for windows? If so look into the original scripts

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_VTK:BOOL=ON \
    -DBUILD_MODULE_Draw:BOOL=OFF \
    -D3RDPARTY_FREETYPE_DIR:PATH=$FREETYPE_INSTALL_DIR \
    -D3RDPARTY_FREETYPE_INCLUDE_DIR_ft2build:PATH=$FREETYPE_INSTALL_DIR/include/freetype2 \
    -D3RDPARTY_FREETYPE_LIBRARY:FILEPATH=$FREETYPE_INSTALL_DIR/lib/$FREETYPE_LIBRARY \
    -D3RDPARTY_FREETYPE_LIBRARY_DIR:PATH=$FREETYPE_INSTALL_DIR/lib \
    -D3RDPARTY_VTK_DIR:PATH=$VTK_INSTALL_DIR \
    -D3RDPARTY_VTK_INCLUDE_DIR:PATH=$VTK_INSTALL_DIR/include/vtk-$VTK_MAJOR_VERSION \
    -D3RDPARTY_VTK_LIBRARY_DIR:PATH=$VTK_INSTALL_DIR/lib \
    -DINSTALL_DIR:PATH=$OPENCASCADE_INSTALL_DIR \
    -DINSTALL_DIR_BIN:PATH=bin \
    -DINSTALL_DIR_LIB:PATH=lib \
..

make -j 2
make install
popd

popd

# create tar
cd install
tar -cf opencascade.tar opencascade-$OPENCASCADE_VERSION
cd ..