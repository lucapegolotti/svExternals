#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://github.com/leethomason/tinyxml2/archive/refs/tags/$TINYXML2_VERSION.tar.gz

# extract source
tar -xf $TINYXML2_VERSION.tar.gz

# delete tar
rm $TINYXML2_VERSION.tar.gz

# create install directory 
mkdir -p $TINYXML2_INSTALL_DIR

# build and install
pushd tinyxml2-$TINYXML2_VERSION
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$TINYXML2_INSTALL_DIR ..
make -j 2 && make install
popd

popd

# create tar
cd install
# this is required for simvascular installation
if [[ $(uname) == 'Linux' ]]; then
    sed -i 's|'${ROOT_DIR}/install'|\$\{SV_EXTERNALS_TOPLEVEL_BIN_DIR\}|g' tinyxml2-$TINYXML2_VERSION/lib/cmake/tinyxml2/tinyxml2Targets.cmake
elif [[ $(uname) == 'Darwin' ]]; then
    sed -i'.original' -e 's|'${ROOT_DIR}/install'|\$\{SV_EXTERNALS_TOPLEVEL_BIN_DIR\}|g' tinyxml2-$TINYXML2_VERSION/lib/cmake/tinyxml2/tinyxml2Targets.cmake
else
    echo 'Operating system not supported'
    exit 125
fi
tar -cf tinyxml2.tar tinyxml2-$TINYXML2_VERSION
cd ..
