#include <CppModel.h>

namespace {
constexpr int m_targetSize{300};
}

CppModel::CppModel(QObject *parent)
    : QAbstractListModel(parent) {
    for (int i = 0; i < m_targetSize; i++)
        m_values.append(QString::number(i));
}
int CppModel::rowCount(const QModelIndex &parent) const {
    return m_values.length();
}
QVariant CppModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }
    QVariant output;
    if (role == Qt::DisplayRole) {
        output = m_values.at(index.row());
    }
    return output;
}
QHash<int, QByteArray> CppModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles.insert(Qt::DisplayRole, "text");
    return roles;
}
QStringList CppModel::rawList() {
    return m_values;
}
void CppModel::prependValueToModel() {
    beginInsertRows(QModelIndex(), 0, 0);
    m_values.prepend("444");
    endInsertRows();
    emit rawListChanged();
}
