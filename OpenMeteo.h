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
    explicit OpenMeteo (EnvironmentModel *model, QObject *parent = nullptr);
    void start();

private:
    QNetworkAccessManager m_network;
    QTimer m_updateTimer;
    EnvironmentModel *m_model;

    void fetchData();
};

#endif // OPENMETEO_H
