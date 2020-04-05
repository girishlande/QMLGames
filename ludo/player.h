#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <piece.h>
#include <qvector.h>

class Player : public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject *parent = nullptr);
    Player(int globalStartIndex,const QString& col);

    void advancePiece(int pieceIndex, int value);

signals:

public slots:

private:
    QVector<Piece*> m_pieces;
    int m_startIndex;
    QString m_color;
};

#endif // PLAYER_H
