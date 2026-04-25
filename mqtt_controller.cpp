#include "mqtt_controller.h"

MqttController::MqttController (QMqttClient *client, QObject *parent)
    : QObject(parent), m_client(client)
{
    connect (m_client, &QMqttClient :: stateChanged, this, [this] (QMqttClient :: ClientState state) {
        bool nowConnected = (state == QMqttClient :: Connected);
        if (m_connected != nowConnected) {
            m_connected = nowConnected;
            emit connectedChanged();
        }
                                                         });

    // receive message
    connect(m_client, &QMqttClient::messageReceived, this, &MqttController::handleMqttmsg);
}


    void MqttController ::handleMqttmsg(const QByteArray &payload, const QMqttTopicName &topic)
    {
        if (topic.name() == "terrarium/mist"){
            bool newState = (payload == "ON");

            if (m_mistOn != newState){
                m_mistOn = newState;
                emit mistOnChanged();
            }
        }
    }

    void MqttController::setMist(bool on){
        if (m_client) {
            m_client->publish(QMqttTopicName("terrarium/mist"), on ? QByteArray("ON") : QByteArray("OFF"));
        }

        if (m_mistOn != on){
            m_mistOn = on;
            emit mistOnChanged();
        }
    }
