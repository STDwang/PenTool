QT += qml quick multimedia multimediawidgets webview webchannel websockets webengine sql webenginewidgets

CONFIG += c++11

SUBDIRS += \
    src/t2d/Toou2D.pro

SOURCES += main.cpp \
    src/mat/fft1.cpp \
    src/mat/rtGetInf.cpp \
    src/mat/rtGetNaN.cpp \
    src/mat/rt_nonfinite.cpp \
    src/mat/test.cpp \
    src/mat/test_emxAPI.cpp \
    src/mat/test_emxutil.cpp \
    src/mat/test_initialize.cpp \
    src/mat/test_terminate.cpp \
    src/qcustomplot/qcustomplot.cpp \
    src/pentoolsever.cpp \
    src/pentoolsql.cpp \
    src/pentoolwork.cpp \
    src/qmlplot.cpp \
    src/sever-sql.cpp \
    src/sever-ui.cpp \
    src/sever-work.cpp \
    src/sql-mb.cpp \
    src/sql-project.cpp \
    src/sql-sates.cpp \
    src/work-creMb.cpp \
    src/work-creSate.cpp \
    src/work-task1.cpp \
    src/work-task2.cpp \
    src/work-task3.cpp \
    src/work-task4.cpp \
    src/t2d/def.cpp \
    src/t2d/qml_plugin.cpp \
    src/t2d/t2d.cpp \
    src/t2d/toou2d.cpp \
    src/t2d/world.cpp \
    src/t2d/theme/theme_binder.cpp \
    src/t2d/theme/theme_handler.cpp \
    src/t2d/theme/ThemeManager.cpp \
    src/t2d/controls/gadget/tcolor.cpp \
    src/t2d/controls/gadget/tgadgetbackground.cpp \
    src/t2d/controls/gadget/tgadgetborder.cpp \
    src/t2d/controls/gadget/tgadgeticon.cpp \
    src/t2d/controls/gadget/tgadgetitem.cpp \
    src/t2d/controls/gadget/tgadgetlabel.cpp \
    src/t2d/controls/gadget/tgadgetscrollbar.cpp \
    src/t2d/controls/interface/tdialogitem.cpp \
    src/t2d/controls/interface/ttoastitem.cpp

RESOURCES += qml.qrc \
    src/t2d/t2d_res.qrc

RC_FILE = \
logo.rc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/mat/fft1.h \
    src/mat/rtGetInf.h \
    src/mat/rtGetNaN.h \
    src/mat/rt_nonfinite.h \
    src/mat/rtwtypes.h \
    src/mat/test.h \
    src/mat/test_emxAPI.h \
    src/mat/test_emxutil.h \
    src/mat/test_initialize.h \
    src/mat/test_terminate.h \
    src/mat/test_types.h \
    src/mat/tmwtypes.h \
    src/qcustomplot/qcustomplot.h \
    src/comfution.h \
    src/lincesecreator.h \
    src/mathfution.h \
    src/pentoolsever.h \
    src/pentoolsql.h \
    src/pentooldatatype.h \
    src/pentoolwork.h \
    src/qmlplot.h \
    src/websockettransport.h \
    src/t2d/def.h \
    src/t2d/qml_plugin.h \
    src/t2d/t2d.h \
    src/t2d/Toou2D.h \
    src/t2d/world.h \
    src/t2d/theme/theme_binder.h \
    src/t2d/theme/theme_handler.h \
    src/t2d/theme/ThemeManager.h \
    src/t2d/controls/gadget/tcolor.h \
    src/t2d/controls/gadget/tgadgetbackground.h \
    src/t2d/controls/gadget/tgadgetborder.h \
    src/t2d/controls/gadget/tgadgeticon.h \
    src/t2d/controls/gadget/tgadgetitem.h \
    src/t2d/controls/gadget/tgadgetlabel.h \
    src/t2d/controls/gadget/tgadgetscrollbar.h \
    src/t2d/controls/interface/tdialogitem.h \
    src/t2d/controls/interface/ttoastitem.h

SUBDIRS += \
    src/t2d/Toou2D.pro

DISTFILES +=
