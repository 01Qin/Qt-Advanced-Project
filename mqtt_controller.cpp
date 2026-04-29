#include "mqtt_controller.h"
#include <QtMqtt/QMqttTopicFilter>

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

    connect(m_client, &QMqttClient::stateChanged, this, [this](QMqttClient::ClientState state){

        if (state == QMqttClient::Connected){
            m_client->subscribe(QMqttTopicFilter("terrarium/mist"), 0);

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
        if (m_client && m_connected) {
            m_client->publish(QMqttTopicName("terrarium/mist"),
                              on ? QByteArray("Mist On") : QByteArray("Mist Off"));
        }

        if (m_mistOn != on){
            m_mistOn = on;
            emit mistOnChanged();
        }
    }
