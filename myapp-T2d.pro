QT += qml quick multimedia multimediawidgets axcontainer webview webchannel websockets webengine sql webenginewidgets

CONFIG += c++11

SOURCES += main.cpp \
    bin/mat/fft1.cpp \
    bin/mat/rtGetInf.cpp \
    bin/mat/rtGetNaN.cpp \
    bin/mat/rt_nonfinite.cpp \
    bin/mat/test.cpp \
    bin/mat/test_emxAPI.cpp \
    bin/mat/test_emxutil.cpp \
    bin/mat/test_initialize.cpp \
    bin/mat/test_terminate.cpp \
    bin/qcustomplot/qcustomplot.cpp \
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
    src/work-task4.cpp

RESOURCES += qml.qrc
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
    bin/mat/fft1.h \
    bin/mat/rtGetInf.h \
    bin/mat/rtGetNaN.h \
    bin/mat/rt_nonfinite.h \
    bin/mat/rtwtypes.h \
    bin/mat/test.h \
    bin/mat/test_emxAPI.h \
    bin/mat/test_emxutil.h \
    bin/mat/test_initialize.h \
    bin/mat/test_terminate.h \
    bin/mat/test_types.h \
    bin/mat/tmwtypes.h \
    bin/qcustomplot/qcustomplot.h \
    src/comfution.h \
    src/lincesecreator.h \
    src/mathfution.h \
    src/pentoolsever.h \
    src/pentoolsql.h \
    src/pentooldatatype.h \
    src/pentoolwork.h \
    src/qmlplot.h \
    src/websockettransport.h
