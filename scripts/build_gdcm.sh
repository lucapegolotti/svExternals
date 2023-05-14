#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://github.com/malaterre/GDCM/archive/refs/tags/v$GDCM_VERSION.tar.gz

# extract source
tar -xf v$GDCM_VERSION.tar.gz

# delete tar
rm v$GDCM_VERSION.tar.gz

# create install directory 
mkdir -p $GDCM_INSTALL_DIR
echo $GDCM_INSTALL_DIR
# build and install
pwd
pushd GDCM-$GDCM_VERSION
if [ "$(uname)" == "Darwin" ]; then
	patch -p1 < $PATCH_DIR/gdcm-$GDCM_VERSION-clang.patch
fi
mkdir -p build && cd build
cmake \
	-DCMAKE_INSTALL_PREFIX=$GDCM_INSTALL_DIR \
	-DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=true \
	..
make -j 2 && make install
popd

popd

# create tar
cd install
tar -cf gdcm.tar gdcm-$GDCM_VERSION
cd ..

