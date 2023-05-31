#!/bin/bash

# below are the content of the post-install script previously in SVExternals.
# I am not sure why we need to change the build directory so much

GCP=cp
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

echo '1'

echo "$GMKDIR -p $MITK_BINDIR/bin"

$GMKDIR -p $MITK_BINDIR/bin
$GMKDIR -p $MITK_BINDIR/lib
$GMKDIR -p $MITK_BINDIR/lib/plugins
$GMKDIR -p $MITK_BINDIR/include

echo '2'

$GCP -Rfl $MITK_BLDDIR/MITK-build/bin $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/MITK-build/lib $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/bin $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/lib $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/include $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/share $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/plugins $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/src/CTK-build/CMakeExternals/Install/include $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/src/CTK-build/CMakeExternals/Install/lib $MITK_BINDIR 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/*.so $MITK_BINDIR/lib 2>/dev/null
$GCP -Rfl $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/*.h $MITK_BINDIR/include
$GCP -Rfl $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/* $MITK_BINDIR/bin 2>/dev/null
$GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*CTK*.so* $MITK_BINDIR/lib 2>/dev/null
$GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/liborg*.so* $MITK_BINDIR/lib/plugins 2>/dev/null

echo '2'

# copy qRestAPI from CTK-build

$GMKDIR -p $MITK_BINDIR/include/qRestAPI
$GCP -fl $MITK_BLDDIR/ep/src/CTK-build/qRestAPI/*.h $MITK_BINDIR/include/qRestAPI 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/$MITK_BLDTYPE/libqRestAPI.REPLACEME_SV_LIB_FILE_EXTENSION $MITK_BINDIR/lib 2>/dev/null
$GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/$MITK_BLDTYPE/libqRestAPI.so* $MITK_BINDIR/bin 2>/dev/null
$GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/qRestAPI-build/$MITK_BLDTYPE/libqRestAPI.so* $MITK_BINDIR/lib 2>/dev/null

echo '3'

# copy PythonQt from CTK-build

$GMKDIR -p $MITK_BINDIR/include/PythonQt
$GCP -fl $MITK_BLDDIR/ep/src/CTK-build/PythonQt/src/*.h $MITK_BINDIR/include/PythonQt 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK-build/PythonQt/src/gui/*.h $MITK_BINDIR/include/PythonQt 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK-build/PythonQt-build/$MITK_BLDTYPE/libPythonQt.a $MITK_BINDIR/lib 2>/dev/null
$GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/PythonQt-build/$MITK_BLDTYPE/libPythonQt.so* $MITK_BINDIR/bin 2>/dev/null
$GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/PythonQt-build/$MITK_BLDTYPE/libPythonQt.so* $MITK_BINDIR/lib 2>/dev/null

echo '4'

# remove libs from $MITK_BINDIR/bin
$GRM -Rf  $MITK_BINDIR/bin/*.so*
$GRM -Rf  $MITK_BINDIR/bin/plugins

# CTK
echo '5'

$GMV -f $MITK_BINDIR/bin/Python $MITK_BINDIR/bin/PythonCTK

$GMKDIR -p $MITK_BINDIR/include/ctk

$GCP -fl $MITK_BLDDIR/ep/src/CTK/Libs/Core/*.h $MITK_BINDIR/include/ctk 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK/Libs/Core/*.tpp $MITK_BINDIR/include/ctk 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK/Libs/Scripting/Python/Core/*.h $MITK_BINDIR/include/ctk 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK/Libs/Scripting/Python/Widgets/*.h $MITK_BINDIR/include/ctk 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK/Libs/Visualization/VTK/Core/*.h $MITK_BINDIR/include/ctk 2>/dev/null
$GCP -fl $MITK_BLDDIR/ep/src/CTK/Libs/Widgets/*.h $MITK_BINDIR/include/ctk

echo '6'

# $GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*.so* $MITK_BINDIR/bin
# $GCP -fl -d $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*.so* $MITK_BINDIR/lib
$GCP -fl $MITK_BLDDIR/ep/src/CTK-build/CTK-build/bin/$MITK_BLDTYPE/*.REPLACEME_SV_LIB_FILE_EXTENSION $MITK_BINDIR/lib 2>/dev/null

# copying more than needed here, but not sure how many of the subdirectories are required.
$GCP -Rf  $MITK_BLDDIR/ep/src/CTK/Libs/PluginFramework $MITK_BINDIR/include/ctk 2>/dev/null

for i in $(find $MITK_BLDDIR/ep/src/CTK-build -name "*Export.h"); do
    echo "$i  $($GBASENAME $i)"
    $GCP -fl $i $MITK_BINDIR/include/ctk
done

echo '7'

#$GCP -fl $MITK_BLDDIR/MITK-build/lib/plugins/$MITK_BLDTYPE/* $MITK_BINDIR/lib/plugins

# mitk files

#$GCP -fl -d $MITK_BLDDIR/MITK-build/bin/$MITK_BLDTYPE/*.so* $MITK_BINDIR/bin
#$GCP -fl -d $MITK_BLDDIR/MITK-build/lib/$MITK_BLDTYPE/*.so* $MITK_BINDIR/lib
#$GCP -fl $MITK_BLDDIR/MITK-build/lib/$MITK_BLDTYPE/*.REPLACEME_SV_LIB_FILE_EXTENSION $MITK_BINDIR/lib

echo '8'

$GMKDIR -p $MITK_BINDIR/include/mitk
$GMKDIR -p $MITK_BINDIR/include/mitk/configs
$GMKDIR -p $MITK_BINDIR/include/mitk/exports
$GMKDIR -p $MITK_BINDIR/include/mitk/ui_files
$GMKDIR -p $MITK_BINDIR/include/mitk/Modules

$GCP $MITK_BLDDIR/MITK-build/*.h $MITK_BINDIR/include/mitk 2>/dev/null

echo '9'

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
    $GCP -R $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i)) 2>/dev/null
done

for i in $MITK_SRCDIR/Plugins/org.mitk.*/src/*; do
    if [ -d $i ];then \
      $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
      $GCP -R $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
    fi
done

for i in $MITK_SRCDIR/Plugins/org.blueberry.*/src; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i))
    $GCP -R $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $i)) 2>/dev/null
done

for i in $MITK_SRCDIR/Plugins/org.blueberry.*/src/*; do
    if [ -d $i ];then \
      $GMKDIR -p $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
      $GCP -R $i/*.h $MITK_BINDIR/include/mitk/plugins/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $i); \
    fi
done

for i in $(find $MITK_BLDDIR/MITK-build/Plugins -name "*Export.h"); do
    echo "$i  $($GBASENAME $i)"
    $GCP -fl $i $MITK_BINDIR/include/mitk/exports 2>/dev/null
done

echo '10'

#
# everything else
#

for i in $MITK_SRCDIR/Modules/*/include; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $i))
    $GCP -R $i $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $i)) 2>/dev/null
done

for i in $MITK_SRCDIR/Modules/*/include; do
    $GCP $MITK_BLDDIR/MITK-build/Modules/$($GBASENAME $($GDIRNAME $i))/ui_*.h $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $i)) 2>/dev/null
done

for i in $MITK_SRCDIR/Modules/*/*/include; do
    $GMKDIR -p $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $($GDIRNAME $i))
    $GCP -R $i $MITK_BINDIR/include/mitk/$($GBASENAME $($GDIRNAME $($GDIRNAME $i)))/$($GBASENAME $($GDIRNAME $i)) 2>/dev/null
done


for i in $(find $MITK_BLDDIR -name "*Exports.h"); do
    echo "$i  $($GBASENAME $i)"
    $GCP -fl $i $MITK_BINDIR/include/mitk/exports 2>/dev/null
done

for i in $(find $MITK_BLDDIR/MITK-build/Modules -name "*Export.h"); do
    echo "$i  $($GBASENAME $i)"
    $GCP -fl $i $MITK_BINDIR/include/mitk/exports 2>/dev/null
done

for i in $(find $MITK_BLDDIR/MITK-build/Modules -name "ui_*.h"); do
    echo "$i  $($GBASENAME $i)"
    $GCP -fl $i $MITK_BINDIR/include/mitk/ui_files 2>/dev/null
done

for i in $(find $MITK_BLDDIR/MITK-build -name "*Config.h"); do
    echo "$i  $($GBASENAME $i)"
    $GCP -fl $i $MITK_BINDIR/include/mitk/configs 2>/dev/null
done

echo '11'

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

echo '12'

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

echo '13'

$GCP -fl $MITK_SRCDIR/Modules/ContourModel/DataManagement/*.h $MITK_BINDIR/include/mitk/Modules/ContourModel/DataManagement 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/CppMicroServices/core/src/module/*.h $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/module 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/CppMicroServices/core/src/service/*.h $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/service 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/CppMicroServices/core/src/util/*.h $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/util 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/CppMicroServices/core/src/module/*.tpp $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/module 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/CppMicroServices/core/src/service/*.tpp $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/service 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/CppMicroServices/core/src/util/*.tpp $MITK_BINDIR/include/mitk/Modules/CppMicroServices/core/src/util 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/ImageDenoising/*.h $MITK_BINDIR/include/mitk/Modules/ImageDenoising 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/ImageDenoising/*.txx $MITK_BINDIR/include/mitk/Modules/ImageDenoising 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/LegacyGL/*.h $MITK_BINDIR/include/mitk/Modules/LegacyGL 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Multilabel/*.h $MITK_BINDIR/include/mitk/Modules/Multilabel 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Overlays/*.h $MITK_BINDIR/include/mitk/Modules/Overlays 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Segmentation/Algorithms/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Algorithms 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Segmentation/Controllers/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Controllers 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Segmentation/Interactions/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Interactions 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Segmentation/SegmentationUtilities/BooleanOperations/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/SegmentationUtilities/BooleanOperations 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/Segmentation/SegmentationUtilities/MorphologicalOperations/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/SegmentationUtilities/MorphologicalOperations
$GCP -fl $MITK_SRCDIR/Modules/SegmentationUI/Qmitk/*.h $MITK_BINDIR/include/mitk/Modules/SegmentationUI/Qmitk 2>/dev/null
$GCP -fl $MITK_SRCDIR/Modules/SurfaceInterpolation/*.h $MITK_BINDIR/include/mitk/Modules/SurfaceInterpolation 2>/dev/null
$GCP -fl $MITK_SRCDIR/Utilities/mbilog/*.h $MITK_BINDIR/include/mitk/Utilities/mbilog 2>/dev/null

echo '14'

$GCP -fl $MITK_BLDDIR/MITK-build/Modules/ContourModel/*.h $MITK_BINDIR/include/mitk/Modules/ContourModel 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/ImageDenoising/*.h $MITK_BINDIR/include/mitk/Modules/ImageDenoising 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/LegacyGL/*.h $MITK_BINDIR/include/mitk/Modules/LegacyGL 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/Multilabel/*.h $MITK_BINDIR/include/mitk/Modules/Multilabel 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/Overlays/*.h $MITK_BINDIR/include/mitk/Modules/Overlays 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/QtWidgets/*.h $MITK_BINDIR/include/mitk/Modules/QtWidgets 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/Segmentation/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/Segmentation/Interactions/*.h $MITK_BINDIR/include/mitk/Modules/Segmentation/Interactions 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/SegmentationUI/*.h $MITK_BINDIR/include/mitk/Modules/SegmentationUI 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/Modules/SurfaceInterpolation/*.h $MITK_BINDIR/include/mitk/Modules/SurfaceInterpolation 2>/dev/null

echo '15'

# copy executable
$GCP -fl $MITK_BLDDIR/MITK-build/bin/MitkWorkbench* $MITK_BINDIR/bin 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/bin/usResourceCompiler* $MITK_BINDIR/bin 2>/dev/null
$GCP -fl $MITK_BLDDIR/MITK-build/bin/MitkPluginGenerator* $MITK_BINDIR/bin 2>/dev/null

echo '16'

# for i in $(find $MITK_BLDDIR/MITK-build/lib/plugins -name "*.so*"); do
#     echo "$i  $($GBASENAME $i)"
#     $GCP -fl $i $MITK_BINDIR/bin/plugins
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

# create tar
cd install
tar -cf mitk.tar mitk-$MITK_VERSION
cd ..