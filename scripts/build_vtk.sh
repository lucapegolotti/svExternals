#!/bin/bash

pushd $SRC_DIR

# download tar 
wget https://www.vtk.org/files/release/$VTK_MAJOR_VERSION/VTK-$VTK_VERSION.tar.gz

# extract source
tar -xf VTK-$VTK_VERSION.tar.gz

# delete tar
rm VTK-$VTK_VERSION.tar.gz

# create install directory 
mkdir -p $VTK_INSTALL_DIR

# apply patch
if [[ $(uname) == "Darwin" ]]; then
    pushd src
    patch -i ../patches/VTK-$VTK_VERSION-clang.patch
    popd
fi

pushd VTK-$VTK_VERSION
mkdir -p build
cd build

cmake \
    -DCMAKE_INSTALL_PREFIX=$VTK_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTING=0 \
    -DBUILD_SHARED_LIBS=1 \
    -DVTK_WRAP_PYTHON=1 \
    -DVTK_QT_VERSION=5 \
    -DPython3_EXECUTABLE:FILEPATH=$PYTHON_INSTALL_DIR/$PYTHON_EXECUTABLE \
    -DPython3_INCLUDE_DIR:FILEPATH=$PYTHON_INSTALL_DIR/$PYTHON_INCLUDE_DIR \
    -DPython3_LIBRARY:FILEPATH=$PYTHON_INSTALL_DIR/$PYTHON_LIBRARY \
    -DQt5Core_DIR=$QT_INSTALL_DIR/lib/cmake/Qt5Core \
    -DQt5Gui_DIR=$QT_INSTALL_DIR/lib/cmake/Qt5Gui \
    -DQt5OpenGL_DIR=$QT_INSTALL_DIR/lib/cmake/Qt5OpenGL \
    -DQt5Widgets_DIR=$QT_INSTALL_DIR/lib/cmake/Qt5Widgets \
    -DQt5_DIR=$QT_INSTALL_DIR_CMAKE \
    -DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES \
    -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES \
    -DVTK_MODULE_ENABLE_VTK_RenderingQt=YES \
    -DVTK_MODULE_ENABLE_VTK_RenderingTk=YES \
    -DCMAKE_BUILD_TYPE=Debug \
    ..

make -j 2
make install
popd

popd

# create tar
cd install
tar -cf vtk.tar vtk-$VTK_VERSION
cd ..
