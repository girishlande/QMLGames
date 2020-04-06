#include "player.h"

Player::Player(QObject *parent) : QObject(parent)
{

}

Player::Player(const int baseIndex,const int baseInnerIndex, const QString &col, Mapper* mapper)
    :m_baseIndex(baseIndex),
      m_baseInnerIndex(baseInnerIndex),
      m_color(col),
      m_mapper(mapper)
{
    m_pieces.push_back(new Piece(this));
    m_pieces.push_back(new Piece(this));
    m_pieces.push_back(new Piece(this));
    m_pieces.push_back(new Piece(this));
}

void Player::advancePiece(int pieceIndex, int value)
{
}

int Player::globalIndex()
{
 return m_baseIndex;
}

QColor Player::col()
{
    return m_color;
}

QString Player::name()
{
    return m_name;
}

void Player::setGlobalIndex(const int index)
{
    if(m_baseIndex!=index) {
        m_baseIndex = index;
        emit globalIndexChanged();
    }
}

void Player::setCol(const QColor col)
{
    if (m_color!=col) {
        m_color = col;
        emit colChanged();
    }
}

void Player::setName(const QString &str)
{
    if(m_name!=str) {
        m_name =str;
        emit nameChanged();
    }
}

int Player::numPieces()
{
    return m_pieces.size();
}

QVector<Piece *> &Player::getPieces()
{
    return m_pieces;
}

int Player::localToGlobalIndex(int localIndex)
{
    int globIndex = (m_baseIndex + localIndex)%52;
    if (localIndex>50) {
        globIndex = m_baseInnerIndex + (localIndex-51);
    }
}

Mapper *Player::mapper()
{
    return m_mapper;
}
