#ifndef CPPLOGIC_H
#define CPPLOGIC_H

#include <QObject>

class CppLogic : public QObject
{
    Q_OBJECT
public:
    CppLogic(QObject *parent = nullptr);
    ~CppLogic() {}

    Q_INVOKABLE QList<double> values();
    Q_INVOKABLE QList<double> calculateSqrt();
    Q_INVOKABLE QList<double> calculateSqrtAsynch();

private:
    QList<double> m_values;
    int           m_valuesCount;
};

#endif // CPPLOGIC_H
