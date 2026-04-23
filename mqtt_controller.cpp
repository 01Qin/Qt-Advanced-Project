#include "mqtt_controller.h"

MqttController::MqttController (QMqttClient *client, QObject *parent)
    : QObject(parent), m_client(client)
{
    connect(m_client, &QMqttClient::msgReceived, this, &MqttController::handleMqttmsg);
}


    void MqttController ::handleMqttmsg(const QString &topic, const QByteArray &payload)
    {
        if (topic == "terrarium/mist"){
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
