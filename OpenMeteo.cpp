#include "OpenMeteo.h"
#include "EnvironmentModel.h"
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

OpenMeteo::OpenMeteo(EnvironmentModel *environment, QObject *parent)
    : QObject(parent), m_environment(environment){
    m_Timer.setInterval(5000); // every 5 sec
    connect (&m_Timer, &QTimer::timeout, this, &OpenMeteo::fetchData);
}

void OpenMeteo::start(){
    fetchData();
    m_Timer.start();

}
void OpenMeteo::stop(){

    m_Timer.stop();

}

void OpenMeteo::fetchData(){
    QUrl url("https://api.open-meteo.com/v1/forecast"
                "?latitude=52.52"
                "&longitude=13.41"
                "&current=temperature_2m,relative_humidity_2m"

             );

    QNetworkRequest request(url);
    auto reply = m_network.get(request);

    connect(reply, &QNetworkReply::finished, this, [this,reply] {
        if (reply->error() != QNetworkReply::NoError){
            reply->deleteLater();
            return;
        }

        const QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
        const QJsonObject root = doc.object();
        const QJsonObject current = root["current"].toObject();

        double temperature = current["temperature_2m"].toDouble();
        double humidity = current["relative_humidity_2m"].toDouble();
        m_environment->setTemperature(temperature);
        m_environment->setHumidity(humidity);
        m_environment->setSource("Open-Meteo");

        reply->deleteLater();

    });
}