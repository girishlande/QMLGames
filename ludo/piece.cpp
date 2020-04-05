#include "piece.h"
#include "player.h"

Piece::Piece(QObject *parent) : QObject(parent)
{
    m_player = dynamic_cast<Player*>(parent);
    m_color = m_player->col();
    m_name = m_player->numPieces();
    m_reached = false;
    m_index = -1;
}

int Piece::index()
{
    return m_index;
}

void Piece::setIndex(int index)
{
    if(m_index!=index) {
        m_index=index;
        emit indexChanged();
    }
}

QColor Piece::color()
{
    return m_color;
}

void Piece::setColor(const QColor color)
{
    if (m_color!=color) {
        m_color = color;
        emit colorChanged();
    }
}

int Piece::name()
{
    return m_name;
}

void Piece::setName(int name)
{
    if (name!=m_name) {
        m_name = name;
        emit nameChanged();
    }
}

bool Piece::reached()
{
    return m_reached;
}

void Piece::setReached(bool flag)
{
    if(m_reached!=flag) {
        m_reached = flag;
        emit reachedChanged();
    }
}

int Piece::xpos()
{

}

void Piece::setXpos(int pos)
{

}

int Piece::ypos()
{

}

void Piece::setYpos(int pos)
{

}
