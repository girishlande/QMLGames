#ifndef PIECE_H
#define PIECE_H

#include <QObject>
#include <qcolor.h>

class Player;
class Piece : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool reached READ reached WRITE setReached NOTIFY reachedChanged)
    Q_PROPERTY(int xpos READ xpos WRITE setXpos NOTIFY xposChanged)
    Q_PROPERTY(int ypos READ ypos WRITE setYpos NOTIFY yposChanged)
public:
    explicit Piece(QObject *parent = nullptr);

    int index();
    void setIndex(int index);

    QColor color();
    void setColor(const QColor color);

    int name();
    void setName(int name);

    bool reached();
    void setReached(bool flag);

    int xpos();
    void setXpos(int pos);

    int ypos();
    void setYpos(int pos);

signals:
    void indexChanged();
    void colorChanged();
    void nameChanged();
    void reachedChanged();

public slots:

private:
    int m_index;
    QColor m_color;
    int m_name;
    bool m_reached;
    Player* m_player;
};

#endif // PIECE_H
