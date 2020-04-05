#include "player.h"

Player::Player(QObject *parent) : QObject(parent)
{

}

Player::Player(int globalStartIndex, const QString &col)
    :m_globalIndex(globalStartIndex),
      m_color(col)
{

}

void Player::advancePiece(int pieceIndex, int value)
{
}

int Player::globalIndex()
{
 return m_globalIndex;
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
    if(m_globalIndex!=index) {
        m_globalIndex = index;
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
