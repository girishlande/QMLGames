#include "playersclub.h"
#include "piecemodel.h"

PlayersClub::PlayersClub(QObject *parent) : QObject(parent)
{
    m_playerTurn = 0;
    QString col1("yellow");
    m_players.push_back(new Player(1,col1));
    QString col2("green");
    m_players.push_back(new Player(14,col2));
    QString col3("red");
    m_players.push_back(new Player(27,col3));
    QString col4("blue");
    m_players.push_back(new Player(40,col4));
}

void PlayersClub::advanceCurrentPlayer(int value)
{
    m_players[m_playerTurn]->advancePiece(0,value);
}

void PlayersClub::getPlayerPieces(PieceModel &model)
{
    // Iterate on all players and get their pieces.
    // Add references of these pieces in input model
    for(int i=0;i<m_players.size();i++) {
        Player* current = m_players[i];
        QVector<Piece*> pieces = current->getPieces();
        for(int j=0;j<pieces.size();j++) {
            Piece* piece = pieces[j];
            model.appendPiece(piece);
        }
    }
}

void PlayersClub::nextPlayer()
{
    m_playerTurn = (m_playerTurn+1)%m_players.size();
}

int PlayersClub::currentPlayer()
{
    return m_playerTurn;
}


