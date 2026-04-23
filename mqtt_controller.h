#ifndef MQTT_CONTROLLER_H
#define MQTT_CONTROLLER_H

#pragma once
#include <QObject>
#include <QMqttClient>

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
    void handleMqttmsg(const QString &topic, const QByteArray &payload);
    Q_INVOKABLE void setMist (bool on);

private:
    QMqttClient *mqttClient = nullptr;
    bool m_mistOn = false;
    bool m_connected = false;
};

#endif // MQTT_CONTROLLER_H
