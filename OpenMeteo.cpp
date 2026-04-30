#include "OpenMeteo.h"
#include "EnvironmentModel.h"
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDate>

OpenMeteo::OpenMeteo(EnvironmentModel *environment, QObject *parent)
    : QObject(parent), m_environment(environment){

    m_Timer.setInterval(60000); // fresh every 1 hour
    connect (&m_Timer, &QTimer::timeout, this, [this](){
        fetchData();
        fetchHistoryData();
    });
}

void OpenMeteo::start(){
    fetchHistoryData();
    fetchData();
    m_Timer.start();

}
void OpenMeteo::stop(){

    m_Timer.stop();

}

void OpenMeteo::fetchData()
{
    QUrl url(
        "https://api.open-meteo.com/v1/forecast"
        "?latitude=60.2276&longitude=24.8873"
        "&hourly=temperature_2m,relative_humidity_2m"
        "&timezone=auto"
        );

    QNetworkRequest request(url);
    auto reply = m_network.get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply] {
        if (reply->error() != QNetworkReply::NoError) {
            reply->deleteLater();
            return;
        }

        const QJsonDocument doc =
            QJsonDocument::fromJson(reply->readAll());
        const QJsonObject root = doc.object();
        const QJsonObject hourly = root["hourly"].toObject();

        const QJsonArray timerArr = hourly["time"].toArray();
        const QString nowStr = QDateTime::currentDateTimeUtc().toString("yyyy-MM-ddThh:00");

        int idx = 0;
        for (int i =0; i < timerArr.size(); ++i){
            if (timerArr[i].toString() == nowStr){
                idx = i;
                break;
            }
        }


        const QJsonArray tempArr =
            hourly["temperature_2m"].toArray();
        const QJsonArray humidityArr =
            hourly["relative_humidity_2m"].toArray();

        if (tempArr.isEmpty() || humidityArr.isEmpty()) {
            reply->deleteLater();
            return;
        }

        double temp = tempArr[idx].toDouble();
        double humidity = humidityArr[idx].toDouble();

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
             "&daily=temperature_2m_max,relative_humidity_2m_mean"
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
        const QJsonObject daily = root["daily"].toObject();
        QJsonArray tempMax = daily["temperature_2m_max"].toArray();
        QJsonArray humidityMean = daily["relative_humidity_2m_mean"].toArray();
        QJsonArray timeArr = daily["time"].toArray();

        for (int i = 0; i < tempMax.size() && i < humidityMean.size(); ++i){
            m_environment->appendTempHistory(tempMax[i].toDouble());
            m_environment->appendHumidityHistory(humidityMean[i].toDouble());

            if (i < timeArr.size()){
                QDate date = QDate::fromString(timeArr[i].toString(), "yyyy-MM-dd");
                m_environment->appendDateHistory(date.toString("MMM d"));
            }

        }
        reply->deleteLater();


    });
}
