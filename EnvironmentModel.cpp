#include "EnvironmentModel.h"

EnvironmentModel::EnvironmentModel(QObject *parent)
    : QObject (parent) {}

double EnvironmentModel::humidity () const {return m_humidity;}
double EnvironmentModel::temp () const {return m_temp;}
QString EnvironmentModel::source() const {return m_source;}
QVariantList EnvironmentModel::tempHistory() const {return m_tempHistory;}
QVariantList EnvironmentModel::humidityHistory() const {return m_humidityHistory;}



void EnvironmentModel::setHumidity (double value){
    // if (m_humidity == value) return;
    m_humidity = value;
    m_valid = true;
    m_humidityHistory.append(value);
    emit humidityChanged(m_humidity);
    emit humidityHistoryChanged();
    emit validChanged();
}

void EnvironmentModel::setTemp(double value){
    if(m_temp == value) return;
    m_temp = value;
    m_valid = true;
    m_tempHistory.append(value);
    emit tempChanged(m_temp);
    emit tempHistoryChanged();
    emit validChanged();
}

void EnvironmentModel::setSource (const QString &value){
    if (m_source == value) return;
    m_source = value;
    emit sourceChanged(m_source);

}

bool EnvironmentModel::valid() const{
    return m_valid;
}

