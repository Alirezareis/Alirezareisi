QT += core gui qml quick quickcontrols2

TEMPLATE = app
TARGET = AlirezaReisiResume

CONFIG += c++17

# Sources & Headers
SOURCES += \
    main.cpp \
    resume_backend.cpp

HEADERS += \
    resume_backend.h

# Resource files (contains QML files and JSON resume data)
RESOURCES += \
    resources.qrc

# Standard deployment rules
target.path = $$[QT_INSTALL_BINS]
INSTALLS += target

# Files to show in Qt Creator file tree
DISTFILES += \
    resume.json \
    qml/main.qml \
    qml/Sidebar.qml \
    qml/GlassCard.qml \
    qml/OverviewPage.qml \
    qml/ExperiencePage.qml \
    qml/SkillsPage.qml \
    qml/ContactPage.qml
