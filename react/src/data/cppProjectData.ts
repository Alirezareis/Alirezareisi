import { CodeFile } from '../types';

export const cppProjectData: CodeFile[] = [
  {
    name: "resume.pro",
    path: "resume.pro",
    language: "pro",
    description: "QMake project configuration declaring core dependencies (gui, qml, quick), resources, and compiler targets for WebAssembly and desktop platforms.",
    content: `QT += core gui qml quick

CONFIG += c++17

# Enable optimizations for release builds
CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
    QMAKE_CXXFLAGS_RELEASE += -O3
}

# WebAssembly specific flags
wasm {
    # Compile as single-threaded for universal compatibility on GitHub Pages
    QMAKE_LFLAGS += -sSINGLE_THREAD=1
    QMAKE_CXXFLAGS += -sSINGLE_THREAD=1
    message("Configuring build for WebAssembly (Single Threaded)...")
}

SOURCES += \\
    main.cpp \\
    resume_backend.cpp

HEADERS += \\
    resume_backend.h

# Resource configuration containing our QML files and the dual-language JSON data
RESOURCES += resources.qrc

# Standard deployment rules
target.path = $$[QT_INSTALL_EXAMPLES]/quick/resume
INSTALLS += target
`
  },
  {
    name: "resume_backend.h",
    path: "resume_backend.h",
    language: "cpp",
    description: "C++ QObject header declaring property bindings, change signals, and language-switching slots for LTR/RTL dynamic layout propagation.",
    content: `#ifndef RESUME_BACKEND_H
#define RESUME_BACKEND_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QJsonObject>

class ResumeBackend : public QObject
{
    Q_OBJECT
    // Bind properties dynamically so that updating currentLanguage triggers automatic UI updates in QML
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(bool isRtl READ isRtl NOTIFY isRtlChanged)
    Q_PROPERTY(QString name READ name NOTIFY resumeDataChanged)
    Q_PROPERTY(QString title READ title NOTIFY resumeDataChanged)
    Q_PROPERTY(QString summary READ summary NOTIFY resumeDataChanged)
    Q_PROPERTY(QVariantList experience READ experience NOTIFY resumeDataChanged)
    Q_PROPERTY(QVariantList skills READ skills NOTIFY resumeDataChanged)
    Q_PROPERTY(QVariantList education READ education NOTIFY resumeDataChanged)

public:
    explicit ResumeBackend(QObject *parent = nullptr);

    // Getters
    QString currentLanguage() const;
    bool isRtl() const;
    QString name() const;
    QString title() const;
    QString summary() const;
    QVariantList experience() const;
    QVariantList skills() const;
    QVariantList education() const;

    // Setters & Slots
    void setCurrentLanguage(const QString &lang);
    
    Q_INVOKABLE void toggleLanguage();
    Q_INVOKABLE bool submitContactForm(const QString &name, const QString &email, const QString &message);

signals:
    void currentLanguageChanged();
    void isRtlChanged();
    void resumeDataChanged();
    void formSubmissionStatus(bool success, QString statusMessage);

private:
    void loadResumeData();
    QJsonObject getActiveLanguageNode() const;

    QString m_currentLanguage; // "en" or "fa"
    QJsonObject m_fullResumeJson;
};

#endif // RESUME_BACKEND_H
`
  },
  {
    name: "resume_backend.cpp",
    path: "resume_backend.cpp",
    language: "cpp",
    description: "C++ implementation of the backend controller. Parses raw JSON assets, handles state variables, and emits state signals to notify the QML render engine.",
    content: `#include "resume_backend.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>

ResumeBackend::ResumeBackend(QObject *parent)
    : QObject(parent)
    , m_currentLanguage("en") // Default English
{
    loadResumeData();
}

void ResumeBackend::loadResumeData()
{
    QFile file(":/resume.json");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open embedded resume.json resource";
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (!doc.isNull() && doc.isObject()) {
        m_fullResumeJson = doc.object();
    } else {
        qWarning() << "Failed to parse resume.json";
    }
}

QJsonObject ResumeBackend::getActiveLanguageNode() const
{
    return m_fullResumeJson.value(m_currentLanguage).toObject();
}

QString ResumeBackend::currentLanguage() const
{
    return m_currentLanguage;
}

bool ResumeBackend::isRtl() const
{
    // If the language is Persian ("fa"), layout direction is Right-to-Left (RTL)
    return m_currentLanguage == "fa";
}

void ResumeBackend::setCurrentLanguage(const QString &lang)
{
    if (m_currentLanguage != lang) {
        m_currentLanguage = lang;
        emit currentLanguageChanged();
        emit isRtlChanged();
        emit resumeDataChanged();
    }
}

void ResumeBackend::toggleLanguage()
{
    if (m_currentLanguage == "en") {
        setCurrentLanguage("fa");
    } else {
        setCurrentLanguage("en");
    }
}

QString ResumeBackend::name() const
{
    return getActiveLanguageNode().value("name").toString();
}

QString ResumeBackend::title() const
{
    return getActiveLanguageNode().value("title").toString();
}

QString ResumeBackend::summary() const
{
    return getActiveLanguageNode().value("summary").toString();
}

QVariantList ResumeBackend::experience() const
{
    QJsonArray arr = getActiveLanguageNode().value("experience").toArray();
    return arr.toVariantList();
}

QVariantList ResumeBackend::skills() const
{
    QJsonArray arr = getActiveLanguageNode().value("skills").toArray();
    return arr.toVariantList();
}

QVariantList ResumeBackend::education() const
{
    QJsonArray arr = getActiveLanguageNode().value("education").toArray();
    return arr.toVariantList();
}

bool ResumeBackend::submitContactForm(const QString &name, const QString &email, const QString &message)
{
    qDebug() << "C++ Slot invoked: submitContactForm";
    qDebug() << "Name:" << name << "| Email:" << email << "| Message:" << message;

    // Simple C++ validation logic
    if (name.trimmed().isEmpty() || !email.contains('@') || message.trimmed().isEmpty()) {
        emit formSubmissionStatus(false, "C++ Error: Validation checks failed inside backend registry.");
        return false;
    }

    // In a real application, this would serialize the message and dispatch an API request or log it
    emit formSubmissionStatus(true, "C++ Success: Form successfully parsed into QJsonObject and dispatched.");
    return true;
}
`
  },
  {
    name: "main.cpp",
    path: "main.cpp",
    language: "cpp",
    description: "Application entry point. Initializes the QGuiApplication, registers the custom ResumeBackend C++ type to QML, and boots the QML engine.",
    content: `#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "resume_backend.h"

int main(int argc, char *argv[])
{
    // High DPI scaling support
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    
    QGuiApplication app(argc, argv);
    app.setApplicationName("Alireza Resume Portfolio");
    app.setApplicationVersion("1.0.0");

    QQmlApplicationEngine engine;

    // Instantiate and register our C++ Backend as a singleton context property
    ResumeBackend *backend = new ResumeBackend(&app);
    engine.rootContext()->setContextProperty("backend", backend);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
`
  },
  {
    name: "main.qml",
    path: "qml/main.qml",
    language: "qml",
    description: "Main viewport controller. Synchronizes layout mirroring (LayoutMirroring) directly to the C++ back-end's 'isRtl' status for instant, smooth UI direction changes.",
    content: `import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    visible: true
    title: backend.name + " - Portfolio"

    // Dynamic layout mirroring mapping - updates layout, alignment, lists, and positions instantly!
    LayoutMirroring.enabled: backend.isRtl
    LayoutMirroring.childrenInherit: true

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#080810" }
            GradientStop { position: 1.0; color: "#12121e" }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Responsive left-aligned/right-aligned navigation drawer
        Sidebar {
            id: sidebar
            Layout.fillHeight: true
            Layout.preferredWidth: 260
        }

        // Active layout contents matching selected menu page
        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: sidebar.activeTab

            OverviewPage { id: overviewPage }
            ExperiencePage { id: experiencePage }
            SkillsPage { id: skillsPage }
            ContactPage { id: contactPage }
        }
    }
}
`
  },
  {
    name: "GlassCard.qml",
    path: "qml/GlassCard.qml",
    language: "qml",
    description: "Reusable custom component for glassmorphic elements. Features frosted-glass opacity, inner glow borders, drop shadows, and visual state hover transitions.",
    content: `import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: glassCard
    radius: 12
    color: Qt.rgba(255, 255, 255, 0.05) // Frosted semi-transparency
    
    // Glass borders
    border.color: Qt.rgba(255, 255, 255, 0.12)
    border.width: 1

    property alias contentChildren: container.children

    // Subtle drop shadow/glow simulated in pure Quick items
    Rectangle {
        anchors.fill: parent
        anchors.margins: -1
        radius: glassCard.radius + 1
        color: "transparent"
        border.color: glassCard.activeFocus || mouseArea.containsMouse ? "#4FACFE" : "transparent"
        border.width: 1
        opacity: 0.5
        Behavior on border.color { ColorAnimation { duration: 250 } }
    }

    Item {
        id: container
        anchors.fill: parent
        anchors.margins: 16
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: glassCard.forceActiveFocus()
    }
}
`
  },
  {
    name: "build.yml",
    path: ".github/workflows/build.yml",
    language: "yaml",
    description: "GitHub Actions CI/CD configuration automating CMake/QMake compilations for Windows, Linux, and WebAssembly targets, then publishing the Web target to GitHub Pages.",
    content: `name: Cross-Platform Build & Deploy

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  # Job 1: Build WebAssembly and deploy to GitHub Pages
  wasm-build-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Emscripten Toolchain (v3.1.50)
        uses: mymindstorm/setup-emsdk@v14
        with:
          version: '3.1.50'

      - name: Install Qt 6.7.x (WASM Target)
        uses: jurplel/install-qt-action@v3
        with:
          version: '6.7.1'
          target: 'desktop'
          arch: 'wasm_singlethread'

      - name: Create Build Directory
        run: mkdir build && cd build

      - name: Run QMake and Compile
        run: |
          cd build
          qmake ..
          make -j$(nproc)

      - name: Deploy WebAssembly Target to GitHub Pages
        if: github.ref == 'refs/heads/main'
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          folder: build/dist # Target build assets directory
          branch: gh-pages

  # Job 2: Build Windows Desktop Target
  windows-build:
    runs-on: windows-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Install Qt 6.7.x (Windows MinGW)
        uses: jurplel/install-qt-action@v3
        with:
          version: '6.7.1'
          arch: 'win64_mingw'

      - name: Setup MinGW compiler path
        run: |
          echo "C:\\Program Files\\mingw64\\bin" >> $GITHUB_PATH

      - name: Compile Windows Build
        run: |
          mkdir build
          cd build
          qmake ..
          mingw32-make -j2

      - name: Package Desktop Executable (windeployqt)
        run: |
          windeployqt --qmldir qml/ build/release/resume.exe

      - name: Upload Windows Executable Artifacts
        uses: actions/upload-artifact@v4
        with:
          name: Qt-Resume-Windows-x64
          path: build/release/

  # Job 3: Build Linux Desktop Target
  linux-build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Install Compilers and OpenGL Dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y build-essential libgl1-mesa-dev libx11-xcb-dev libglu1-mesa-dev

      - name: Install Qt 6.7.x (Linux Desktop)
        uses: jurplel/install-qt-action@v3
        with:
          version: '6.7.1'
          arch: 'gcc_64'

      - name: Compile Linux Binary
        run: |
          mkdir build
          cd build
          qmake ..
          make -j$(nproc)

      - name: Upload Linux Binary Artifact
        uses: actions/upload-artifact@v4
        with:
          name: Qt-Resume-Linux-x64
          path: build/resume
`
  }
];
