#ifndef PLAYERSCLUB_H
#define PLAYERSCLUB_H

#include <QObject>
#include <QVector>
#include <player.h>

class PieceModel;
class PlayersClub : public QObject
{
    Q_OBJECT
public:
    explicit PlayersClub(QObject *parent = nullptr);

    Q_INVOKABLE void advanceCurrentPlayer(int value);

    void getPlayerPieces(PieceModel& model);

    void nextPlayer();
    int currentPlayer();

signals:

public slots:

private:
    QVector<Player*> m_players;
    int m_playerTurn;
};

#endif // PLAYERSCLUB_H
