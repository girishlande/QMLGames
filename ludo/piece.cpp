#include "piece.h"
#include "player.h"

Piece::Piece(QObject *parent) : QObject(parent)
{

}

Piece::Piece(int name, int index)
    :m_localIndex(index),
      m_name(name),
      m_reached(false)
{

}

int Piece::index()
{
    return m_localIndex;
}

void Piece::setIndex(int index)
{
    if(m_localIndex!=index) {
        m_localIndex=index;
        emit indexChanged();
    }
}

QString Piece::color()
{
    return m_color;
}

void Piece::setColor(const QString color)
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
