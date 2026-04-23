#include "mqtt_controller.h"

MqttController::MqttController (QObject *parent)
    : QObject(parent) {}


    void MqttController ::handleMqttmsg(const QString &topic const QByteArray &payload)
    {
        if (topic == "terririum/mist"){
            bool newState = (payload == "ON");

            if (m_mistOn != newState){
                m_mistOn = newState;
                emit mistOnChanged();
            }
        }
    }

    void MqttController::setMist(bool on){
        mqttClient->publis("terrarium/mist", on ? "ON" : "OFF");

        if (m_mistOn != on){
            m_mistOn = on;
            emit mistOnChanged();
        }
    }
