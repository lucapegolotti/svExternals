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

# -DGDCM_WRAP_PYTHON=1 \
# -DSWIG_EXECUTABLE=$SWIG_INSTALL_DIR/bin/swig \
# -DSWIG_DIR=$SWIG_INSTALL_DIR \
# -DSWIG_VERSION=$SWIG_VERSION \
# -DPYTHON_DEBUG_LIBRARY="" \
# -DPYTHON_EXECUTABLE=$PYTHON_INSTALL_DIR/bin/python \
# -DPYTHON_INCLUDE_DIR=$PYTHON_INSTALL_DIR/include \
# -DPYTHON_INCLUDE_DIR2=$PYTHON_INSTALL_DIR/REPLACEME_SV_PYTHON_INCLUDE_DIR \
# -DPYTHON_LIBRARY=$PYTHON_INSTALL_DIR/lib/libpython$PYTHON_MAJOR_VERSION.PYTHON_MINOR_VERSION.so \
# -DPYTHON_LIBRARY_DEBUG="" \

cmake \
	-DCMAKE_INSTALL_PREFIX=$GDCM_INSTALL_DIR \
	-DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=true \
	-DGDCM_BUILD_SHARED_LIBS=1 \
  	-DGDCM_USE_VTK=0 \
  	-DGDCM_BUILD_APPLICATIONS=1 \
	-DGDCM_BUILD_DOCBOOK_MANPAGES=0 \
	..
make -j 2 && make install
popd

popd

# create tar
cd install
tar -cf gdcm.tar gdcm-$GDCM_VERSION
cd ..

