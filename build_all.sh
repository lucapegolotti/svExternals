#!/bin/bash

# halt on error
set -e

source scripts/library_versions.sh

CUR_DIR=$(pwd)

# set directories
export SRC_DIR=$CUR_DIR'/src'
export INSTALL_DIR=$CUR_DIR'/install'
export PATCH_DIR=$CUR_DIR'/patches'

# create directories
mkdir -p $SRC_DIR
mkdir -p $INSTALL_DIR

# export CC=gcc-8
# export CXX=g++-8

# 
BUILD_TCL=1
BUILD_QT=0
BUILD_HDF5=1
BUILD_TINYXML2=1
BUILD_PYTHON=1
BUILD_FREETYPE=1
BUILD_SWIG=1
BUILD_MMG=1
BUILD_GDCM=1
BUILD_VTK=0
BUILD_ITK=0
BUILD_OPENCASCADE=0
BUILD_MITK=0

# build libraries. Even if the bool above are 0, we enter the scripts
# as they set relevant env variables
mkdir -p output
source scripts/build_tcl.sh > output/tcl.out
source scripts/build_qt.sh > output/qt.out
source scripts/build_hdf5.sh > output/hdf5.out
source scripts/build_tinyxml2.sh > output/tinyxml2.out
source scripts/build_python.sh > output/python.out
source scripts/build_freetype.sh > output/freetype.out
source scripts/build_swig.sh > output/swig.out
source scripts/build_mmg.sh > output/mmg.out
source scripts/build_gdcm.sh > output/gdcm.out
source scripts/build_vtk.sh > output/vtk.out
source scripts/build_itk.sh > output/itk.out
source scripts/build_opencascade.sh > output/opencascade.out
source scripts/build_mitk.sh > output/mitk.out
