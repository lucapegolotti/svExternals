#!/bin/bash

pushd $SRC_DIR

GDCM_MAJOR_VERSION=${GDCM_VERSION%.*}

export GDCM_INSTALL_DIR=$INSTALL_DIR/gdcm-$GDCM_VERSION
export GDCM_INCLUDE_DIR=$GDCM_INSTALL_DIR/include/gdcm-$GDCM_MAJOR_VERSION
export GDCM_CMAKE_DIR=$GDCM_INSTALL_DIR/lib/gdcm-$GDCM_MAJOR_VERSION

if [[ $BUILD_GDCM -eq 1 ]]
then
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
	make -j 4 && make install
	popd
fi

popd
