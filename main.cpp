#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtMqtt/QtMqtt>
#include "EnvironmentModel.h"
#include "OpenMeteo.h"
#include <QQmlContext>
#include "mqtt_controller.h"



int main(int argc, char *argv[])
{
    qputenv("LIBGL_ALWAYS_SOFTWARE", "1");
    qputenv("MESA_LOADER_DRIVER_OVERRIDE", "llvmpipe");
    qputenv("GALLIUM_DRIVER", "llvmpipe");
    qputenv("QT_QUICK_BACKEND", "software");
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QApplication app(argc, argv);

    EnvironmentModel environment;
    OpenMeteo meteo (&environment);

    // mqtt
    QMqttClient mqttClient;
    mqttClient.setHostname("broker.hivemq.com");
    mqttClient.setPort(1883);
    mqttClient.connectToHost();
    MqttController mqttController(&mqttClient);


    QQmlApplicationEngine engine;

    // register all context properties before and load()
    engine.rootContext()->setContextProperty("environment", &environment);
    engine.rootContext()->setContextProperty("simulator", &meteo);
    engine.rootContext()->setContextProperty("mqtt", &mqttController);


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("Smart_Terrarium", "Main");

    meteo.start();

    return QCoreApplication::exec();
}
