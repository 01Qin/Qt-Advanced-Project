#ifndef ENVIRONMENTMODEL_H
#define ENVIRONMENTMODEL_H

#pragma once
#include <QObject>

class EnvironmentModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(double humidity READ humidity NOTIFY dataChanged)
    Q_PROPERTY(double temperature READ temperature NOTIFY dataChanged)
    Q_PROPERTY(QString source READ source NOTIFY dataChanged)
    Q_PROPERTY(QVarianList temperatureHistory READ temperatureHistoryy NOTIFY historyChanged)
    Q_PROPERTY(QVarianList humidiyHistory READ humidityHistoryy NOTIFY historyChanged)

public:
    explicit EnvironmentModel (QObject *parent = nullptr);
    double humidity() const;
    double temperature() const;
    QString source() const;


    void setHumidity(double value);
    void setTemperature (double value);
    void setSource (const QString &value);

signals:
    void dataChanged();

private:
    double m_humidity = 0.0;
    double m_temperature = 0.0;
    QString m_source = "Unknown";
    QVariantList m_temperatureHistory;
    QVariantList m_humidityHistory;
};

#endif // ENVIRONMENTMODEL_H
