#!/bin/bash

# halt on error
set -e

source env_variables.sh

# create directories
mkdir -p $SRC_DIR
mkdir -p $INSTALL_DIR

# export CC=gcc-8
# export CXX=g++-8


BUILD_TCL=1
BUILD_TK=1
BUILD_QT=1
BUILD_HDF5=1
BUILD_TINYXML2=1
BUILD_PYTHON=1
BUILD_FREETYPE=1
BUILD_SWIG=1
BUILD_MMG=1
BUILD_GDCM=1
BUILD_VTK=1
BUILD_ITK=1
BUILD_OPENCASCADE=1
BUILD_MITK=1

mkdir -p output
if [[ $BUILD_TCL -eq 1 ]]
then
    source scripts/build_tcl.sh > output/tcl.out
fi
if [[ $BUILD_TK -eq 1 ]]
then
    source scripts/build_tk.sh > output/tk.out
fi
if [[ $BUILD_QT -eq 1 ]]
then
    source scripts/build_qt.sh > output/qt.out
fi
if [[ $BUILD_HDF5 -eq 1 ]]
then
    source scripts/build_hdf5.sh > output/hdf5.out
fi
if [[ $BUILD_TINYXML2 -eq 1 ]]
then
    source scripts/build_tinyxml2.sh > output/tinyxml2.out
fi
if [[ $BUILD_PYTHON -eq 1 ]]
then
    source scripts/build_python.sh > output/python.out
fi
if [[ $BUILD_FREETYPE -eq 1 ]]
then
    source scripts/build_freetype.sh > output/freetype.out
fi
if [[ $BUILD_SWIG -eq 1 ]]
then
    source scripts/build_swig.sh > output/swig.out
fi
if [[ $BUILD_MMG -eq 1 ]]
then
    source scripts/build_mmg.sh > output/mmg.out
fi
if [[ $BUILD_GDCM -eq 1 ]]
then
    source scripts/build_gdcm.sh > output/gdcm.out
fi 
if [[ $BUILD_VTK -eq 1 ]]
then
    source scripts/build_vtk.sh > output/vtk.out
fi
if [[ $BUILD_ITK -eq 1 ]]
then
    source scripts/build_itk.sh > output/itk.out
fi
if [[ $BUILD_OPENCASCADE -eq 1 ]]
then
    source scripts/build_opencascade.sh > output/opencascade.out
fi
if [[ $BUILD_MITK -eq 1 ]]
then
    source scripts/build_mitk.sh > output/mitk.out
fi
