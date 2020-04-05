#include "piecemodel.h"

PieceModel::PieceModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_pieces.push_back(new Piece(0,-1));
    m_pieces.push_back(new Piece(1,-1));
    m_pieces.push_back(new Piece(2,-1));
    m_pieces.push_back(new Piece(3,-1));
}

int PieceModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_pieces.size();
}

QVariant PieceModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Piece* piece = m_pieces.at(index.row());
    switch (role) {
    case IndexRole: return QVariant(piece->index());
    case ColorRole: return QVariant(piece->color());
    case NameRole: return QVariant(piece->name());
    case ReachedRole: return QVariant(piece->reached());
    }
    // FIXME: Implement me!
    return QVariant();
}

bool PieceModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Piece* piece = m_pieces.at(index.row());
    switch (role) {
    case IndexRole: piece->setIndex(value.toInt());break;
    case ColorRole: piece->setColor(value.toString()); break;
    case NameRole: piece->setName(value.toInt());break;
    case ReachedRole: piece->setReached(value.toBool()); break;
    }
    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags PieceModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> PieceModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names[IndexRole] = "index";
    names[ColorRole] = "col";
    names[NameRole] = "name";
    names[ReachedRole] = "reached";
    return names;
}


