#include <CppLogic.h>
#include <QRandomGenerator>
#include <QtConcurrent>

CppLogic::CppLogic(QObject *parent)
    : QObject(parent) {
    m_valuesCount = 1000000;
    for (int i = 0; i < m_valuesCount; i++) {
        m_values.append(QRandomGenerator::global()->generateDouble());
    }
}

QList<double> CppLogic::values() {
    return m_values;
}

QList<double> CppLogic::calculateSqrt() {
    QList<double> output;

    for (const double &val : m_values) {
        output.append(sqrt(val));
    }

    return output;
}

QList<double> CppLogic::calculateSqrtAsynch() {
    QList<double> sequenceToModify = values();
    QtConcurrent::blockingMap(sequenceToModify, [=](double &val) {
        val = sqrt(val);
    });
    return sequenceToModify;
}
