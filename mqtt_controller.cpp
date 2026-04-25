#include "mqtt_controller.h"

MqttController::MqttController (QMqttClient *client, QObject *parent)
    : QObject(parent), m_client(client)
{
    connect (m_client, &QMqttClient :: stateChanged, this, QMqttClient :: ClientState state{
        bool nowConnected = (state == QMqttClient :: Connected);
        if (m_connected != nowConnected) {
            m_connected = nowConnected;
            emit connectedChanged();
                                                         });

    // receive message
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
        if (m_client) {
            m_client->publish("terrarium/mist", on ? "ON" : "OFF");
        }

        if (m_mistOn != on){
            m_mistOn = on;
            emit mistOnChanged();
        }
    }
