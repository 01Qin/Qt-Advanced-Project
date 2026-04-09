#include "EnvironmentModel.h"

EnvironmentModel::EnvironmentModel(QObject *parent)
    : QObject (parent) {}

double EnvironmentModel::humidity () const {return m_humidity;}
double EnvironmentModel::temperature () const {return m_temperature;}
QString EnvironmentModel::source() const {return m_source;}

void EnvironmentModel::setHumidity (double value){
    if (m_humidity == value) return;
    m_humidity = value;
    emit dataChanged();
}

void EnvironmentModel::setTemperature(double value){
    if(m_temperature == value) return;
    m_temperature = value;
    emit dataChanged();
}

void EnvironmentModel::setSource (const QString &value){
    if (m_source == value) return;
    m_source = value;
    emit dataChanged();
}