#!/bin/bash

pushd $SRC_DIR

# download tar 
ITK_MAJOR_VERSION=${ITK_VERSION%.*}
wget https://github.com/InsightSoftwareConsortium/ITK/releases/download/v$ITK_VERSION/InsightToolkit-$ITK_VERSION.tar.gz

# extract source
tar -xf InsightToolkit-$ITK_VERSION.tar.gz

# delete tar
rm InsightToolkit-$ITK_VERSION.tar.gz

# create install directory 
mkdir -p $ITK_INSTALL_DIR

pushd InsightToolkit-$ITK_VERSION
# rm -r -p build
mkdir -p build
cd build

# this option makes compilation fail
# -DBUILD_SHARED_LIBS=1 \

cmake \
    -DCMAKE_INSTALL_PREFIX=$ITK_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_EXAMPLES=0 \
    -DBUILD_TESTING=0 \
    -DITK_USE_SYSTEM_GDCM=1 \
    -DITK_USE_SYSTEM_HDF5=1 \
    -DModule_ITKReview=1 \
    -DModule_ITKVtkGlue=1 \
    -DGDCM_DIR=$GDCM_CMAKE_DIR \
    -DHDF5_DIR=$HDF5_CMAKE_DIR \
    -DVTK_DIR=$VTK_CMAKE_DIR \
    -DQt5_DIR=$QT_INSTALL_DIR/lib/cmake/Qt5 \
    -DITK_USE_SYSTEM_ZLIB:BOOL=ON \
    -DPython3_ROOT_DIR=$PYTHON_INSTALL_DIR \
..

make -j 8
make install
popd

popd

# create tar
cd install
tar -cf itk.tar itk-$ITK_VERSION
cd ..

