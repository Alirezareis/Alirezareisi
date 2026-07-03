#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QtQml>
#include "resume_backend.h"

int main(int argc, char *argv[])
{
    // Force a customizable style to prevent native control customization warnings
    QQuickStyle::setStyle("Basic");

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    
    app.setOrganizationName("AlirezaReisi");
    app.setOrganizationDomain("github.com/Alirezareis");
    app.setApplicationName("AlirezaReisiResume");

    qmlRegisterType<ResumeBackend>("Resume", 1, 0, "ResumeBackend");

    QQmlApplicationEngine engine;
    
    ResumeBackend backend;
    engine.rootContext()->setContextProperty("backend", &backend);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
