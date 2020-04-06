#include "piece.h"
#include "player.h"

Piece::Piece(QObject *parent) : QObject(parent)
{
    m_player = dynamic_cast<Player*>(parent);
    m_color = m_player->col();
    m_name = m_player->numPieces();
    m_reached = false;
    m_index = 0;
    int gIndex = m_player->localToGlobalIndex(m_index);
    m_xpos = m_player->mapper()->getX(gIndex);
    m_ypos = m_player->mapper()->getY(gIndex);
}

int Piece::index()
{
    return m_index;
}

void Piece::setIndex(int index)
{
    if(m_index!=index) {
        m_index=index;
        int gIndex = m_player->localToGlobalIndex(index);
        int xpos = m_player->mapper()->getX(gIndex);
        int ypos = m_player->mapper()->getY(gIndex);
        setXpos(xpos);
        setYpos(ypos);
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
    return m_xpos;
}

void Piece::setXpos(int pos)
{
    if (m_xpos != pos) {
        m_xpos = pos;
        emit xposChanged();
    }
}

int Piece::ypos()
{
    return m_ypos;
}

void Piece::setYpos(int pos)
{
    if (m_ypos != pos) {
        m_ypos = pos;
        emit yposChanged();
    }
}

void Piece::advancePosition(int value)
{
    setIndex(index()+value);
}
