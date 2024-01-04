#ifndef SEQUENCETYPE_HPP
#define SEQUENCETYPE_HPP

#include <QQuickItem>

class SequenceType : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QList<qreal> qrealListProperty READ qrealListProperty WRITE setQrealListProperty NOTIFY qrealListPropertyChanged)

public:
    SequenceType() : QQuickItem() { m_list << 1.1 << 2.2 << 3.3; }
    ~SequenceType() {}

    QList<qreal> qrealListProperty() const { return m_list; }
    void         setQrealListProperty(const QList<qreal> &list) {
        m_list = list;
        emit qrealListPropertyChanged();
    }

signals:
    void qrealListPropertyChanged();

private:
    QList<qreal> m_list;
};

#endif // SEQUENCETYPE_HPP
