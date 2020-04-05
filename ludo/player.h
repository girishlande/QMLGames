#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <piece.h>
#include <qvector.h>
#include <qcolor.h>

class Player : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int globalIndex READ globalIndex WRITE setGlobalIndex NOTIFY globalIndexChanged)
    Q_PROPERTY(QColor col READ col WRITE setCol NOTIFY colChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    explicit Player(QObject *parent = nullptr);
    Player(const int globalStartIndex,const QString& col);

    void advancePiece(int pieceIndex, int value);
    int globalIndex();
    QColor col();
    QString name();

    void setGlobalIndex(const int index);
    void setCol(const QColor col);
    void setName(const QString& str);
    int numPieces();

    QVector<Piece*>& getPieces();

signals:
   void globalIndexChanged();
   void colChanged();
   void nameChanged();

public slots:

private:
    QVector<Piece*> m_pieces;

    int m_globalIndex;
    QColor m_color;
    QString m_name;
};

#endif // PLAYER_H
