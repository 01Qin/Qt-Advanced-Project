#ifndef MQTT_CONTROLLER_H
#define MQTT_CONTROLLER_H

#pragma once
#include <QObject>

class MqttController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool mistOn READ mistOn  NOTIFY mistOnChanged )

public:
    explicit MqttController (QObject *parent = nullptr);
    bool mistOn() const { return m_mistOn; }

signals:
    void mistOnChanged();

public slots:
    void handleMqttmsg(const QString &topic, const QByteArray &payload);
    Q_INVOKABLE void setMist (bool on);

private:
    bool m_mistOn = false;
};

#endif // MQTT_CONTROLLER_H
