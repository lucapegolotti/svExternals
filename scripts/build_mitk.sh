#!/bin/bash

pushd $SRC_DIR

# for some reason these directories are not found
export PATH=$QT_INSTALL_DIR_CMAKE:$PATH
export PATH=$PYTHON_INSTALL_DIR/bin:$PATH
export PATH=$TINYXML2_INSTALL_DIR_CMAKE:$PATH
export PATH=$TINYXML2_INSTALL_DIR/lib:$PATH
export PATH=$TINYXML2_INSTALL_DIR/include:$PATH
export PATH=$GDCM_INCLUDE_DIR:$PATH
export PATH=$VTK_INSTALL_DIR/lib:$PATH

# # download tar 
wget https://github.com/MITK/MITK/archive/refs/tags/v$MITK_VERSION.tar.gz

# extract source
tar -xf v$MITK_VERSION.tar.gz

# delete tar
rm v$MITK_VERSION.tar.gz

# create install directory 
mkdir -p $MITK_INSTALL_DIR

pushd MITK-$MITK_VERSION

# apply patch
patch -p1 < $PATCH_DIR/mitk-$MITK_VERSION.patch

mkdir -p build
cd build

# removed flags
# -DMITK_PYTHON_SITE_DIR:PATH=REPLACEME_SV_TOP_BLD_DIR_MITK/ep/lib/pythonREPLACEME_SV_PYTHON_MAJOR_VERSION.REPLACEME_SV_PYTHON_MINOR_VERSION/site-packages \
# REPLACEME_CMAKE_C_COMPILER \
# REPLACEME_CMAKE_CXX_COMPILER \
# -DQt5Script_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Script \
#         -DMITK_ADDITIONAL_CXX_FLAGS:STRING="-fpermissive -DVCL_CAN_STATIC_CONST_INIT_FLOAT=0 -isystem /usr/local/sv/ext/2022.10/release/gl2/bin/gnu/7.5/x64/gdcm-2.6.3/include/gdcm-2.6/" \
# -DMITK_ADDITIONAL_C_FLAGS:STRING="-fpermissive -DVCL_CAN_STATIC_CONST_INIT_FLOAT=0 -isystem /usr/local/sv/ext/2022.10/release/gl2/bin/gnu/7.5/x64/gdcm-2.6.3/include/gdcm-2.6/" \
#         -Dtinyxml2_DIR:PATH=$TINYXML2_INSTALL_DIR \

echo $PATH

cmake \
    -DMITK_USE_SUPERBUILD=1 \
    -DMITK_USE_GDCM=1 \
    -DMITK_BUILD_EXAMPLES=0 \
    -DBUILD_TESTING=0 \
    -DMITK_USE_Python3=1 \
    -DMITK_USE_SWIG=1 \
    -DBUILD_SHARED_LIBS=1 \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DEXTERNAL_GDCM_DIR:PATH=$GDCM_INSTALL_DIR \
    -DEXTERNAL_ITK_DIR:PATH=$ITK_INSTALL_DIR \
    -DEXTERNAL_VTK_DIR:PATH=$VTK_INSTALL_DIR \
    -DSWIG_EXECUTABLE:PATH=$SWIG_EXECUTABLE \
    -DSWIG_DIR:PATH=$SWIG_INSTALL_DIR \
    -D_Python3_EXECUTABLE:PATH=$PYTHON_INSTALL_DIR/$PYTHON_EXECUTABLE \
    -D_Python3_INCLUDE_DIR:PATH=$PYTHON_INSTALL_DIR/$PYTHON_INCLUDE_DIR \
    -DQt5_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5 \
    -DQt5Concurrent_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Concurrent \
    -DQt5Core_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Core \
    -DQt5Gui_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Gui \
    -DQt5Help_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Help \
    -DQt5Network_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Network \
    -DQt5OpenGL_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5OpenGL \
    -DQt5PrintSupport_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5PrintSupport \
    -DQt5Sql_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Sql \
    -DQt5Svg_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Svg \
    -DQt5UiTools_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5UiTools \
    -DQt5WebEngineWidgets_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5WebEngineWidgets \
    -DQt5Widgets_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Widgets \
    -DQt5XmlPatterns_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5XmlPatterns \
    -DQt5Xml_DIR:PATH=$QT_INSTALL_DIR/lib/cmake/Qt5Xml \
    -DCMAKE_INSTALL_PREFIX:PATH=$MITK_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_OBJECT_PATH_MAX:STRING=1000 \
    -DPython3_ROOT_DIR=$PYTHON_INSTALL_DIR \
    -DCMAKE_PREFIX_PATH:PATH="$ITK_INSTALL_DIR_CMAKE" \
    -DQt5_DIR:PATH=$QT_INSTALL_DIR_CMAKE \
    -DCMAKE_C_FLAGS=-I$GDCM_INCLUDE_DIR \
    -DCMAKE_CXX_FLAGS=-I$GDCM_INCLUDE_DIR \
..

make -j 4
make install
popd

popd

# create tar
cd install
tar -cf mitk.tar mitk-$MITK_VERSION
cd ..
