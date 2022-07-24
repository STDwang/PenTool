QT          += qml quick svg
CONFIG      += c++11

RESOURCES += \
    t2d_res.qrc

# Input
HEADERS += \
        qml_plugin.h \
        Toou2D.h \
        t2d.h \
        def.h \
        world.h \
        theme/theme_binder.h \
        theme/theme_handler.h \
        theme/ThemeManager.h \
        controls/interface/ttoastitem.h \
        controls/interface/tdialogitem.h \
        controls/gadget/tgadgetlabel.h \
        controls/gadget/tgadgetborder.h \
        controls/gadget/tgadgetbackground.h \
        controls/gadget/tgadgeticon.h \
        controls/gadget/tgadgetscrollbar.h \
        controls/gadget/tgadgetitem.h \
        controls/gadget/tcolor.h


SOURCES += \
        qml_plugin.cpp \
        toou2d.cpp \
        t2d.cpp \
        def.cpp \
        world.cpp \
        theme/theme_binder.cpp \
        theme/theme_handler.cpp \
        theme/ThemeManager.cpp \
        controls/interface/ttoastitem.cpp \
        controls/interface/tdialogitem.cpp \
        controls/gadget/tgadgetlabel.cpp \
        controls/gadget/tgadgetborder.cpp \
        controls/gadget/tgadgetbackground.cpp \
        controls/gadget/tgadgeticon.cpp \
        controls/gadget/tgadgetscrollbar.cpp \
        controls/gadget/tgadgetitem.cpp \
        controls/gadget/tcolor.cpp
