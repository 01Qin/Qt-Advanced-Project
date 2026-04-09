#ifndef ENVIRONMENTMODEL_H
#define ENVIRONMENTMODEL_H

#pragma once
#include <QObject>

class EnvironmentModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(double humidity READ humidity WRITE setHumidity NOTIFY dataChanged)
    Q_PROPERTY(double data READ data WRITE setData NOTIFY dataChanged)
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged)

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
};

#endif // ENVIRONMENTMODEL_H
