#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://download-mirror.savannah.gnu.org/releases/freetype/freetype-old/freetype-$FREETYPE_VERSION.tar.gz

# extract source
tar -xf freetype-$FREETYPE_VERSION.tar.gz

# delete tar
rm freetype-$FREETYPE_VERSION.tar.gz

# create install directory 
mkdir -p $FREETYPE_INSTALL_DIR
echo $FREETYPE_INSTALL_DIR
# build and install
pushd freetype-$FREETYPE_VERSION
./configure --prefix=$FREETYPE_INSTALL_DIR
make -j 4 && make install
popd

popd

# create tar
cd install
tar -cf freetype.tar freetype-$FREETYPE_VERSION
cd ..
