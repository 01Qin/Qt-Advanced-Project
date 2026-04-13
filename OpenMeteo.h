#ifndef OPENMETEO_H
#define OPENMETEO_H

#pragma once
#include <QObject>
#include <QNetworkAccessManager>
#include <QTimer>

class EnvironmentModel;

class OpenMeteo : public QObject {
    Q_OBJECT

public:
    explicit OpenMeteo (EnvironmentModel *environment, QObject *parent = nullptr);
    void start(); // start periodic update
    void stop();

private:
    QNetworkAccessManager m_network;
    QTimer m_Timer;
    EnvironmentModel *m_environment;

    void fetchData();
    void fetchHistoryData();
};

#endif // OPENMETEO_H
