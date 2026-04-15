#ifndef ENVIRONMENTMODEL_H
#define ENVIRONMENTMODEL_H

#pragma once
#include <QObject>
#include <QVariantList>

class EnvironmentModel : public QObject {
    Q_OBJECT
    Q_PROPERTY(double humidity READ humidity WRITE setHumidity NOTIFY humidityChanged)
    Q_PROPERTY(double temp READ temp WRITE setTemp NOTIFY tempChanged)
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QVariantList tempHistory READ tempHistory NOTIFY tempHistoryChanged)
    Q_PROPERTY(QVariantList humidityHistory READ humidityHistory NOTIFY humidityHistoryChanged)
    Q_PROPERTY(bool valid READ valid NOTIFY validChanged)

public:
    explicit EnvironmentModel (QObject *parent = nullptr);
    bool valid() const;


    // Getters
    double humidity() const;
    double temp() const;
    QString source() const;
    QVariantList tempHistory() const;
    QVariantList humidityHistory() const;

public slots:
    void setHumidity(double value);
    void setTemp (double value);
    void setSource (const QString &value);

signals:
    void humidityChanged(double value);
    void tempChanged(double value);
    void sourceChanged(const QString &value);
    void tempHistoryChanged();
    void humidityHistoryChanged();
    void validChanged();


private:
    double m_humidity = 0.0;
    double m_temp = 0.0;
    QString m_source = "Unknown";
    QVariantList m_tempHistory;
    QVariantList m_humidityHistory;
    bool m_valid = false;
};

#endif // ENVIRONMENTMODEL_H