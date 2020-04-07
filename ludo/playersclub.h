#ifndef PLAYERSCLUB_H
#define PLAYERSCLUB_H

#include <QObject>
#include <QVector>
#include <player.h>

class Mapper;
class PieceModel;
class PlayersClub : public QObject
{
    Q_OBJECT
public:
    explicit PlayersClub(Mapper* mapper, QObject *parent = nullptr);

    void getPlayerPieces(PieceModel& model);

    void nextPlayer();
    int currentPlayer();

signals:

public slots:

private:
    QVector<Player*> m_players;
    int m_playerTurn;
    Mapper* m_mapper;
};

#endif // PLAYERSCLUB_H
