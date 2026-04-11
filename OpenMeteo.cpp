#include "OpenMeteo.h"
#include "EnvironmentModel.h"
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

OpenMeteo::OpenMeteo(EnvironmentModel *model, QObject *parent)
    : QObject(parent), m_model(model){
    m_updateTimer.setInterval(5000); // every 5 sec
        connect (&m_updateTimer, &QTimer::timeout, this, &OpenMeteo::fetchData);
}

void OpenMeteo::start(){
    m_model->setSource("Open-Meteo");
    m_updateTimer.start();
    fetchData();
}

void OpenMeteo::fetchData(){
    QUrl url("https://api.open-meteo.com/v1/forecast"
                "?latitude=52.52"
                "&longitude=13.41"
                "&current=temperature_2m,"
                "relative_humidity_2m"

             );

    QNetworkRequest request(url);
    auto reply = m_network.get(request);

    connect(reply, &QNetworkReply::finished, this, [this,reply] {
        const auto json = QJsonDocument::fromJson(reply->readAll()).object();
        const auto current = json["current"].toObject();

        m_model->setTemperature(current["temperature_2m"].toDouble());
        m_model->setHumidity(current["relative_humidity_2m"].toDouble());
        reply->deleteLater();

    });
}