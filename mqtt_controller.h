#ifndef MQTT_CONTROLLER_H
#define MQTT_CONTROLLER_H

#pragma once
#include <QObject>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttTopicName>

class MqttController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool mistOn READ mistOn  NOTIFY mistOnChanged )
    Q_PROPERTY(bool connected READ connected  NOTIFY connectedChanged FINAL)

public:
    explicit MqttController (QMqttClient *client, QObject *parent = nullptr);
    bool mistOn() const { return m_mistOn; }
    bool connected() const { return m_connected; }

signals:
    void mistOnChanged();
    void connectedChanged();

public slots:
    void handleMqttmsg(const QByteArray &payload, const QMqttTopicName &topic);
    Q_INVOKABLE void setMist (bool on);

private:
    QMqttClient *m_client = nullptr;
    bool m_mistOn = false;
    bool m_connected = false;
};

#endif // MQTT_CONTROLLER_H
