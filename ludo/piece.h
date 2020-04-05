#ifndef PIECE_H
#define PIECE_H

#include <QObject>

class Player;
class Piece : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged)
    Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool reached READ reached WRITE setReached NOTIFY reachedChanged)
public:
    explicit Piece(QObject *parent = nullptr);
    Piece(int name,int color);

    int index();
    void setIndex(int index);

    QString color();
    void setColor(const QString color);

    int name();
    void setName(int name);

    bool reached();
    void setReached(bool flag);


signals:
    void indexChanged();
    void colorChanged();
    void nameChanged();
    void reachedChanged();

public slots:

private:
    int m_localIndex;
    QString m_color;
    int m_name;
    bool m_reached;
    Player* m_parent;
};

#endif // PIECE_H
