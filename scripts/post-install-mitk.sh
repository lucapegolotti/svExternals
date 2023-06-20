#!/bin/bash

# below are the content of the post-install script previously in SVExternals.
# I am not sure why we need to change the build directory so much

GCP="rsync -azh --ignore-missing-args"
GDIRNAME=dirname
GBASENAME=basename
GMKDIR=mkdir
GRM=rm
GMV=mv

# paths

export MITK_SRCDIR=${ROOT_DIR}/src/MITK-$MITK_VERSION
export MITK_BINDIR=$MITK_INSTALL_DIR
export MITK_BLDDIR=${ROOT_DIR}/src/MITK-$MITK_VERSION/build

# build type not used on linux
export MITK_BLDTYPE=

# primary directories to install into
$GMKDIR -p $MITK_BINDIR/bin
$GMKDIR -p $MITK_BINDIR/lib
$GMKDIR -p $MITK_BINDIR/lib/plugins
$GMKDIR -p $MITK_BINDIR/include

$GCP $MITK_BLDDIR/MITK-build/bin $MITK_BINDIR
$GCP $MITK_BLDDIR/MITK-build/lib $MITK_BINDIR  
$GCP $MITK_BLDDIR/ep/bin $MITK_BINDIR
$GCP $MITK_BLDDIR/ep/lib $MITK_BINDIR
$GCP $MITK_BLDDIR/ep/include $MITK_BINDIR
$GCP $MITK_BLDDIR/ep/share $MITK_BINDIR
# $GCP -Rfl $MITK_BLDDIR/ep/plugins $MITK_BINDIR

$GCP $MITK_BLDDIR/ep/src/CTK-build/CMakeExternals/Install/include $MITK_BINDIR  
$GCP $MITK_BLDDIR/ep/src/CTK-build/CMakeExternals/Install/lib $MITK_BINDIR  
$GCP $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/*.so $MITK_BINDIR/lib  
$GCP $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/*.h $MITK_BINDIR/include
$GCP $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/* $MITK_BINDIR/bin  
$GCP $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*CTK*.so* $MITK_BINDIR/lib  
# $GCP  -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/liborg*.so* $MITK_BINDIR/lib/plugins  

# copy qRestAPI from CTK-build

$GMKDIR -p $MITK_BINDIR/include/qRestAPI
$GCP $MITK_BLDDIR/ep/src/CTK-build/qRestAPI/*.h $MITK_BINDIR/include/qRestAPI  
# $GCP  $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/$MITK_BLDTYPE/libqRestAPI.a $MITK_BINDIR/lib  
$GCP $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/$MITK_BLDTYPE/libqRestAPI.so* $MITK_BINDIR/bin  
$GCP $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/$MITK_BLDTYPE/libqRestAPI.so* $MITK_BINDIR/lib  

# copy PythonQt from CTK-build

$GMKDIR -p $MITK_BINDIR/include/PythonQt
$GCP $MITK_BLDDIR/ep/src/CTK-build/PythonQt/src/*.h $MITK_BINDIR/include/PythonQt  
$GCP $MITK_BLDDIR/ep/src/CTK-build/PythonQt/src/gui/*.h $MITK_BINDIR/include/PythonQt  
# $GCP  $MITK_BLDDIR/ep/src/CTK-build/PythonQt-build/$MITK_BLDTYPE/libPythonQt.a $MITK_BINDIR/lib  
$GCP $MITK_BLDDIR/ep/src/CTK-build/PythonQt-build/$MITK_BLDTYPE/libPythonQt.so* $MITK_BINDIR/bin  
$GCP $MITK_BLDDIR/ep/src/CTK-build/PythonQt-build/$MITK_BLDTYPE/libPythonQt.so* $MITK_BINDIR/lib  

# remove libs from $MITK_BINDIR/bin
$GRM -Rf  $MITK_BINDIR/bin/*.so*
$GRM -Rf  $MITK_BINDIR/bin/plugins

# CTK

$GMV -f $MITK_BINDIR/bin/Python $MITK_BINDIR/bin/PythonCTK

$GMKDIR -p $MITK_BINDIR/include/ctk

$GCP $MITK_BLDDIR/ep/src/CTK/Libs/Core/*.h $MITK_BINDIR/include/ctk  
$GCP $MITK_BLDDIR/ep/src/CTK/Libs/Core/*.tpp $MITK_BINDIR/include/ctk  
$GCP $MITK_BLDDIR/ep/src/CTK/Libs/Scripting/Python/Core/*.h $MITK_BINDIR/include/ctk  
$GCP $MITK_BLDDIR/ep/src/CTK/Libs/Scripting/Python/Widgets/*.h $MITK_BINDIR/include/ctk  
$GCP $MITK_BLDDIR/ep/src/CTK/Libs/Visualization/VTK/Core/*.h $MITK_BINDIR/include/ctk  
$GCP $MITK_BLDDIR/ep/src/CTK/Libs/Widgets/*.h $MITK_BINDIR/include/ctk

# $GCP  -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*.so* $MITK_BINDIR/bin
# $GCP  -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*.so* $MITK_BINDIR/lib
# $GCP  $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*.a $MITK_BINDIR/lib  

# copying more than needed here, but not sure how many of the subdirectories are required.
$GCP $MITK_BLDDIR/ep/src/CTK/Libs/PluginFramework $MITK_BINDIR/include/ctk  

for i in $(find $MITK_BLDDIR/ep/src/CTK-build -name "*Export.h"); do
    $GCP $i $MITK_BINDIR/include/ctk
done

#$GCP  $MITK_BLDDIR/MITK-build/lib/plugins/$MITK_BLDTYPE/* $MITK_BINDIR/lib/plugins

# mitk files

#$GCP  -d $MITK_BLDDIR/MITK-build/bin/$MITK_BLDTYPE/*.so* $MITK_BINDIR/bin
#$GCP  -d $MITK_BLDDIR/MITK-build/lib/$MITK_BLDTYPE/*.so* $MITK_BINDIR/lib
#$GCP  $MITK_BLDDIR/MITK-build/lib/$MITK_BLDTYPE/*.REPLACEME_SV_LIB_FILE_EXTENSION $MITK_BINDIR/lib

$GMKDIR -p $MITK_BINDIR/include/mitk
$GMKDIR -p $MITK_BINDIR/include/mitk/configs
$GMKDIR -p $MITK_BINDIR/include/mitk/exports
$GMKDIR -p $MITK_BINDIR/include/mitk/ui_files
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules

$GCP $MITK_BLDDIR/MITK-build/*.h $MITK_BINDIR/include/mitk  

#
#  plugins
#

# currently require the following plugins:
#
# org.blueberry.core.runtime  (nested)
# org.blueberry.ui.qt (nested)
# org.mitk.core.services
# org.mitk.gui.common
# org.mitk.gui.qt.common
# org.mitk.gui.qt.common.legacy
# org.mitk.gui.qt.datamanager

for i in $MITK_SRCDIR/Plugins/org.mitk.*/src; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i))
    $GCP $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i))  
done

for i in $MITK_SRCDIR/Plugins/org.mitk.*/src/*; do
    if [ -d $i ];then \
      $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
      $GCP $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
    fi
done

for i in $MITK_SRCDIR/Plugins/org.blueberry.*/src; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i))
    $GCP $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i))  
done

for i in $MITK_SRCDIR/Plugins/org.blueberry.*/src/*; do
    if [ -d $i ];then \
      $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
      $GCP $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
    fi
done

for i in $(find $MITK_BLDDIR/MITK-build/Plugins -name "*Export.h"); do
    $GCP $i $MITK_BINDIR/include/mitk/exports  
done

#
# everything else
#
for i in $MITK_SRCDIR/Modules/*/include; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $i))
    $GCP $i $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $i))
done

for i in $MITK_SRCDIR/Modules/*/include; do
    if [ -d $MITK_BLDDIR/MITK-build/Modules/$($GBASENAME $($GDIRNAME $i)) ]; then
        $GCP $MITK_BLDDIR/MITK-build/Modules/$($GBASENAME $($GDIRNAME $i))/ui_*.h $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $i))  
    fi
done

for i in $MITK_SRCDIR/Modules/*/*/include; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $($GDIRNAME $i))
    $GCP $i $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $($GDIRNAME $i))  
done

for i in $(find $MITK_BLDDIR -name "*Exports.h"); do
    $GCP $i $MITK_BINDIR/include/mitk/exports  
done

for i in $(find $MITK_BLDDIR/MITK-build/Modules -name "*Export.h"); do
    $GCP $i $MITK_BINDIR/include/mitk/exports  
done

for i in $(find $MITK_BLDDIR/MITK-build/Modules -name "ui_*.h"); do
    $GCP $i $MITK_BINDIR/include/mitk/ui_files  
done

for i in $(find $MITK_BLDDIR/MITK-build -name "*Config.h"); do
    $GCP $i $MITK_BINDIR/include/mitk/configs  
done

$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/ContourModel/DataManagement
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/module
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/service
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/util
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/ImageDenoising
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/LegacyGL
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Multilabel
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Overlays
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation/Algorithms
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation/Controllers
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation/Interactions
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation/SegmentationUtilities/BooleanOperations
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation/SegmentationUtilities/MorphologicalOperations
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/SegmentationUI/Qmitk
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/SurfaceInterpolation

$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/ContourModel
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/ImageDenoising
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/LegacyGL
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Multilabel
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Overlays
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/QtWidgets
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/Segmentation/Interactions
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/SegmentationUI
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules/SurfaceInterpolation
$GMKDIR -p $MITK_BINDIR/include/mitk/Utilities/mbilog

$GCP $MITK_SRCDIR/Modules/ContourModel/DataManagement/*.h $MITK_BINDIR/include/mitk/Modules/ContourModel/DataManagement  
$GCP $MITK_SRCDIR/Modules/CppMicroServices/core/src/module/*.h $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/module  
$GCP $MITK_SRCDIR/Modules/CppMicroServices/core/src/service/*.h $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/service  
$GCP $MITK_SRCDIR/Modules/CppMicroServices/core/src/util/*.h $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/util  
$GCP $MITK_SRCDIR/Modules/CppMicroServices/core/src/module/*.tpp $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/module  
$GCP $MITK_SRCDIR/Modules/CppMicroServices/core/src/service/*.tpp $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/service  
$GCP $MITK_SRCDIR/Modules/CppMicroServices/core/src/util/*.tpp $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/util  
$GCP $MITK_SRCDIR/Modules/ImageDenoising/*.h $MITK_BINDIR/include/mitk/Modules/ImageDenoising  
$GCP $MITK_SRCDIR/Modules/ImageDenoising/*.txx $MITK_BINDIR/include/mitk/Modules/ImageDenoising  
$GCP $MITK_SRCDIR/Modules/LegacyGL/*.h $MITK_BINDIR/include/mitk/Modules/LegacyGL  
$GCP $MITK_SRCDIR/Modules/Multilabel/*.h $MITK_BINDIR/include/mitk/Modules/Multilabel  
# $GCP $MITK_SRCDIR/Modules/Overlays/*.h $MITK_BINDIR/include/mitk/Modules/Overlays  
$GCP $MITK_SRCDIR/Modules/Segmentation/Algorithms/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Algorithms  
$GCP $MITK_SRCDIR/Modules/Segmentation/Controllers/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Controllers  
$GCP $MITK_SRCDIR/Modules/Segmentation/Interactions/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Interactions  
$GCP $MITK_SRCDIR/Modules/Segmentation/SegmentationUtilities/BooleanOperations/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/SegmentationUtilities/BooleanOperations  
$GCP $MITK_SRCDIR/Modules/Segmentation/SegmentationUtilities/MorphologicalOperations/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/SegmentationUtilities/MorphologicalOperations
$GCP $MITK_SRCDIR/Modules/SegmentationUI/Qmitk/*.h $MITK_BINDIR/include/mitk/Modules/SegmentationUI/Qmitk  
$GCP $MITK_SRCDIR/Modules/SurfaceInterpolation/*.h $MITK_BINDIR/include/mitk/Modules/SurfaceInterpolation  
$GCP $MITK_SRCDIR/Utilities/mbilog/*.h $MITK_BINDIR/include/mitk/Utilities/mbilog  

$GCP $MITK_BLDDIR/MITK-build/Modules/ContourModel/*.h $MITK_BINDIR/include/mitk/Modules/ContourModel  
$GCP $MITK_BLDDIR/MITK-build/Modules/ImageDenoising/*.h $MITK_BINDIR/include/mitk/Modules/ImageDenoising  
$GCP $MITK_BLDDIR/MITK-build/Modules/LegacyGL/*.h $MITK_BINDIR/include/mitk/Modules/LegacyGL  
$GCP $MITK_BLDDIR/MITK-build/Modules/Multilabel/*.h $MITK_BINDIR/include/mitk/Modules/Multilabel  
# $GCP $MITK_BLDDIR/MITK-build/Modules/Overlays/*.h $MITK_BINDIR/include/mitk/Modules/Overlays  
$GCP $MITK_BLDDIR/MITK-build/Modules/QtWidgets/*.h $MITK_BINDIR/include/mitk/Modules/QtWidgets  
$GCP $MITK_BLDDIR/MITK-build/Modules/Segmentation/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation  
# $GCP $MITK_BLDDIR/MITK-build/Modules/Segmentation/Interactions/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Interactions  
$GCP $MITK_BLDDIR/MITK-build/Modules/SegmentationUI/*.h $MITK_BINDIR/include/mitk/Modules/SegmentationUI  
$GCP $MITK_BLDDIR/MITK-build/Modules/SurfaceInterpolation/*.h $MITK_BINDIR/include/mitk/Modules/SurfaceInterpolation  

# copy executable
$GCP $MITK_BLDDIR/MITK-build/bin/MitkWorkbench* $MITK_BINDIR/bin  
$GCP $MITK_BLDDIR/MITK-build/bin/usResourceCompiler* $MITK_BINDIR/bin  
$GCP $MITK_BLDDIR/MITK-build/bin/MitkPluginGenerator* $MITK_BINDIR/bin  

# for i in $(find $MITK_BLDDIR/MITK-build/lib/plugins -name "*.so*"); do
#     echo "$i  $($GBASENAME $i)"
#     $GCP  $i $MITK_BINDIR/bin/plugins
# done

# create a wrapper script for python executable

echo "#!/bin/sh -f" > ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "export LD_LIBRARY_PATH=${MITK_INSTALL_DIR}/lib:\$LD_LIBRARY_PATH" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "export LD_LIBRARY_PATH=${MITK_INSTALL_DIR}/bin:\$LD_LIBRARY_PATH" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "export PYTHONHOME=${PYTHON_INSTALL_DIR}" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "export PYTHONPATH=${PYTHON_INSTALL_DIR}/lib/${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}/lib-dynload:${PYTHON_INSTALL_DIR}/lib:${PYTHON_INSTALL_DIR}/lib/python${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}:${PYTHON_INSTALL_DIR}/lib/python${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}/site-packages" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "if [ \"\$#\" -gt 0 ]" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "then" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "  ${MITK_INSTALL_DIR}/bin/MitkWorkbench \"\$1\" \"\$2\" \"\$3\" \"\$4\" \"\$5\" " >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "else" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "  ${MITK_INSTALL_DIR}/bin/MitkWorkbench" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
echo "fi" >> ${MITK_INSTALL_DIR}/bin/workbench-wrapper
chmod u+w,a+rx ${MITK_INSTALL_DIR}/bin/workbench-wrapper

# org_mitk_gui_qt_segmentation_Export.h is missing in mitk-2022.10 for some reason
cp ${ROOT_DIR}/patches/files/org_mitk_gui_qt_segmentation_Export.h ${MITK_INSTALL_DIR}/include/mitk/plugins/org.mitk.gui.qt.segmentation/

# create tar
cd install
tar -cf mitk.tar mitk-$MITK_VERSION
cd ..