#include "resume_backend.h"
#include <QFile>
#include <QJsonArray>
#include <QDebug>
#include <QTextStream>
#include <QClipboard>
#include <QGuiApplication>

ResumeBackend::ResumeBackend(QObject *parent)
    : QObject(parent)
    , m_currentLanguage("en")
{
    loadResumeData();
}

void ResumeBackend::loadResumeData()
{
    QFile file(":/resume.json");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open resume data file from resources!";
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(data, &parseError);
    if (doc.isNull()) {
        qWarning() << "Failed to parse JSON resume data:" << parseError.errorString();
        return;
    }

    m_rootJson = doc.object();
}

QJsonObject ResumeBackend::getActiveData() const
{
    return m_rootJson.value(m_currentLanguage).toObject();
}

QString ResumeBackend::currentLanguage() const
{
    return m_currentLanguage;
}

void ResumeBackend::setCurrentLanguage(const QString &lang)
{
    if (m_currentLanguage != lang) {
        m_currentLanguage = lang;
        emit currentLanguageChanged();
        emit isRtlChanged();
        emit dataChanged();
    }
}

bool ResumeBackend::isRtl() const
{
    return m_currentLanguage == "fa";
}

QString ResumeBackend::name() const
{
    return getActiveData().value("personal").toObject().value("name").toString();
}

QString ResumeBackend::title() const
{
    return getActiveData().value("personal").toObject().value("title").toString();
}

QString ResumeBackend::location() const
{
    return getActiveData().value("personal").toObject().value("location").toString();
}

QString ResumeBackend::phone() const
{
    return getActiveData().value("personal").toObject().value("phone").toString();
}

QString ResumeBackend::email() const
{
    return getActiveData().value("personal").toObject().value("email").toString();
}

QString ResumeBackend::github() const
{
    return getActiveData().value("personal").toObject().value("github").toString();
}

QString ResumeBackend::githubUrl() const
{
    return getActiveData().value("personal").toObject().value("githubUrl").toString();
}

QString ResumeBackend::linkedin() const
{
    return getActiveData().value("personal").toObject().value("linkedin").toString();
}

QString ResumeBackend::linkedinUrl() const
{
    return getActiveData().value("personal").toObject().value("linkedinUrl").toString();
}

QString ResumeBackend::summary() const
{
    return getActiveData().value("summary").toString();
}

QVariantList ResumeBackend::experience() const
{
    return getActiveData().value("experience").toArray().toVariantList();
}

QVariantList ResumeBackend::education() const
{
    return getActiveData().value("education").toArray().toVariantList();
}

QVariantList ResumeBackend::skills() const
{
    return getActiveData().value("skills").toArray().toVariantList();
}

QVariantList ResumeBackend::languages() const
{
    return getActiveData().value("languages").toArray().toVariantList();
}

QVariantMap ResumeBackend::ui() const
{
    return getActiveData().value("ui").toObject().toVariantMap();
}

void ResumeBackend::toggleLanguage()
{
    if (m_currentLanguage == "en") {
        setCurrentLanguage("fa");
    } else {
        setCurrentLanguage("en");
    }
}

QVariantList ResumeBackend::getSourceFiles() const
{
    QVariantList files;
    
    auto addFile = [&](const QString &name, const QString &path, const QString &lang, const QString &desc) {
        QVariantMap file;
        file["name"] = name;
        file["path"] = path;
        file["language"] = lang;
        file["description"] = desc;
        files.append(file);
    };

    addFile("main.qml", "qml/main.qml", "qml", "Main application layout, global header, navigation, and workspace tab cards.");
    addFile("ResumeViewer.qml", "qml/ResumeViewer.qml", "qml", "Interactive resume layout manager with macOS-style simulated title bar.");
    addFile("Sidebar.qml", "qml/Sidebar.qml", "qml", "Terminal-style sidebar with navigation menus and memory mapped QObject properties.");
    addFile("OverviewPage.qml", "qml/OverviewPage.qml", "qml", "Overview tab featuring glassmorphic profile cards, avatar, and contact chips.");
    addFile("ExperiencePage.qml", "qml/ExperiencePage.qml", "qml", "Timeline page showing professional experiences wrapped in glass cards.");
    addFile("SkillsPage.qml", "qml/SkillsPage.qml", "qml", "Dynamic skill percentage bars and education cards.");
    addFile("ContactPage.qml", "qml/ContactPage.qml", "qml", "Direct contact panel and an interactive message sender with state simulation.");
    addFile("GlassCard.qml", "qml/GlassCard.qml", "qml", "Custom UI card utilizing radial gradients and border glows to achieve glassmorphism.");
    addFile("resume_backend.h", "resume_backend.h", "cpp", "C++ Header defining the main ResumeBackend QObject properties, slots, and methods.");
    addFile("resume_backend.cpp", "resume_backend.cpp", "cpp", "C++ Source implementing translation loading, properties, and file read operations.");
    addFile("main.cpp", "main.cpp", "cpp", "Application entry point initializing QGuiApplication, QQmlApplicationEngine, and C++ context properties.");
    addFile("resume.pro", "resume.pro", "pro", "QMake project configuration script detailing compile flags, packages, and resource bindings.");
    
    return files;
}

QString ResumeBackend::getSourceFileContent(const QString &path) const
{
    QFile file(":/" + path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return QString("Error: Could not open file %1").arg(path);
    }
    QTextStream in(&file);
    QString content = in.readAll();
    file.close();
    return content;
}

void ResumeBackend::copyToClipboard(const QString &text) const
{
    QGuiApplication::clipboard()->setText(text);
}
