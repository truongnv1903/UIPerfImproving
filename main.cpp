#include <CppLogic.h>
#include <CppModel.h>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <SequenceType.hpp>

int main(int argc, char *argv[]) {
    QGuiApplication       app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<CppLogic>("qt.io", 1, 0, "CppLogic");
    qmlRegisterType<CppModel>("qt.io", 1, 0, "CppModel");
    qmlRegisterType<SequenceType>("qt.io", 1, 0, "SequenceType");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    //    const QUrl url(QStringLiteral("qrc:/dynamicUI.qml"));
    //    const QUrl url(QStringLiteral("qrc:/callLater.qml"));
    //    const QUrl url(QStringLiteral("qrc:/dynamicList.qml"));
    //    const QUrl url(QStringLiteral("qrc:/resolvingProperties.qml"));
    //    const QUrl url(QStringLiteral("qrc:/propertyBindings.qml"));
    //    const QUrl url(QStringLiteral("qrc:/sequenceType.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     },
                     Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
