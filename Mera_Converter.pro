QT += gui core qml quick widgets printsupport

SOURCES += \
        main.cpp \
        appengine.cpp \
        file_explorer.cpp \
        FileHandler/FileHandler.cpp

RC_ICONS += ./QML/imports/icon.ico

resources.files = main.qml 
resources.prefix = /$${TARGET}
RESOURCES += \
    $$files(QML/*)\
    qtquickcontrols2.conf

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = QML/imports

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

#для MinGW
#LIBS += -fopenmp
#QMAKE_LFLAGS += -fopenmp
#QMAKE_CXXFLAGS += -fopenmp


# для MSVC
LIBS += -openmp
QMAKE_LFLAGS += -openmp
QMAKE_CXXFLAGS += -openmp


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += appengine.h \
    file_explorer.h \
    FileHandler/FileHandler.h

DISTFILES += \
    QML/content/SampleNumberField.qml \
    QML/content/SampleNumberField_copy
