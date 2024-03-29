// .NAME __org_mitk_gui_qt_segmentation_Export - manage Windows system differences
// .SECTION Description
// The __org_mitk_gui_qt_segmentation_Export captures some system differences between Unix
// and Windows operating systems. 

#ifndef __org_mitk_gui_qt_segmentation_Export_h
#define __org_mitk_gui_qt_segmentation_Export_h

#include <QtGlobal>
 
#if defined(Q_OS_WIN) || defined(Q_OS_SYMBIAN)
  #  if defined(org_mitk_gui_qt_segmentation_EXPORTS)
#    define MITK_QT_SEGMENTATION Q_DECL_EXPORT
#  else
#    define MITK_QT_SEGMENTATION Q_DECL_IMPORT
#  endif
#endif

#if !defined(MITK_QT_SEGMENTATION)
//#  if defined(CTK_SHARED)
#    define MITK_QT_SEGMENTATION Q_DECL_EXPORT
//#  else
//#    define MITK_QT_SEGMENTATION
//#  endif
#endif

#endif