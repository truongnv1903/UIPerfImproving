#ifndef CPPMODEL_H
#define CPPMODEL_H

#include <QAbstractListModel>

class CppModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QStringList rawList READ rawList NOTIFY rawListChanged)
public:
    explicit CppModel(QObject *parent = nullptr);
    // QAbstractItemModel interface
    virtual int                    rowCount(const QModelIndex &parent) const override;
    virtual QVariant               data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
    QStringList                    rawList();
    Q_INVOKABLE void               prependValueToModel();
signals:
    void rawListChanged();

private:
    QStringList m_values;
};

#endif // CPPMODEL_H
