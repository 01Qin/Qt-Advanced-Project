#include "OpenMeteo.h"
#include "EnvironmentModel.h"
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

OpenMeteo::OpenMeteo(EnvironmentModel *environment, QObject *parent)
    : QObject(parent), m_environment(environment){

    m_Timer.setInterval(5000); // fresh every 5 sec
    connect (&m_Timer, &QTimer::timeout, this, &OpenMeteo::fetchData);
}

void OpenMeteo::start(){
    fetchData();
    fetchHistoryData();
    m_Timer.start();

}
void OpenMeteo::stop(){

    m_Timer.stop();

}

void OpenMeteo::fetchData(){
    QUrl url("https://api.open-meteo.com/v1/forecast?latitude=60.2276"
             "&longitude=24.8873&daily=temperature_2m_max,temperature_2m_min"
             "&hourly=temperature_2m,relative_humidity_2m"
             "&current=temperature_2m,relative_humidity_2m,is_day&timezone=auto"

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

        double temp = current["temperature_2m"].toDouble();
        double humidity = current["relative_humidity_2m"].toDouble();
        m_environment->setTemp(temp);
        m_environment->setHumidity(humidity);
        m_environment->setSource("Open-Meteo");

        reply->deleteLater();

    });
}

void OpenMeteo::fetchHistoryData(){
    QUrl url("https://api.open-meteo.com/v1/forecast"
             "?latitude=60.2276&longitude=24.8873"
             "&past_days=10"
             "&daily=temperature_2m_max,temperature_2m_min"
             "&relative_humidity_2m_mean"
             "&timezone=auto"

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
        const QJsonObject daily = root["daily"].toObject();
        QJsonArray tempMax = daily["temperature_2m_max"].toArray();
        QJsonArray humidityMean = daily["relative_humidity_2m_mean"].toArray();

        for (int i = 0; i < tempMax.size() && i < humidityMean.size(); ++i){
            m_environment->setTemp(tempMax[i].toDouble());
            m_environment->setHumidity(humidityMean[i].toDouble());


        reply->deleteLater();
        }

    });
}