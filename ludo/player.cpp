#include "player.h"

Player::Player(QObject *parent) : QObject(parent)
{

}

Player::Player(int globalStartIndex, const QString &col)
    :m_startIndex(globalStartIndex),
      m_color(col)
{
    m_pieces.push_back(new Piece(0,-1,col));
    m_pieces.push_back(new Piece(1,-1,col));
    m_pieces.push_back(new Piece(2,-1,col));
    m_pieces.push_back(new Piece(3,-1,col));
}

void Player::advancePiece(int pieceIndex, int value)
{
    Piece* selected = m_pieces[pieceIndex];
    int index = selected->index();
    selected->setIndex(index+value);
}
