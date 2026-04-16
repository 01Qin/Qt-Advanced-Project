#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "EnvironmentModel.h"
#include "OpenMeteo.h"
#include <QQmlContext>


int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    EnvironmentModel environment;
    OpenMeteo meteo (&environment);
    meteo.start();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("environment", &environment);
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/Smart_Terrarium/Main.qml")));
    engine.rootContext()->setContextProperty("simulator", &meteo);


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Smart_Terrarium", "Main");

    return QCoreApplication::exec();
}
