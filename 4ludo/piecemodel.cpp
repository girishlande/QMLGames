#include "piecemodel.h"

PieceModel::PieceModel(QObject *parent)
    : QAbstractListModel(parent)
{
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
    case XposRole: return QVariant(piece->xpos());
    case YposRole: return QVariant(piece->ypos());
    }
    // FIXME: Implement me!
    return QVariant();
}

bool PieceModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool change = false;
    Piece* piece = m_pieces.at(index.row());
    switch (role) {
    case IndexRole: change = piece->index()!=value.toInt(); break;
    case ColorRole: change = piece->color()!=value.toString(); break;
    case NameRole: change = piece->name()!= value.toInt(); break;
    case ReachedRole: change = piece->reached()!=value.toBool(); break;
    case XposRole: change = piece->xpos()!=value.toInt(); break;
    case YposRole: change = piece->ypos()!=value.toInt(); break;
    }

    if(!change) {
        return false;
    }

    switch (role) {
    case IndexRole: piece->setIndex(value.toInt());break;
    case ColorRole: piece->setColor(value.toString()); break;
    case NameRole: piece->setName(value.toInt());break;
    case ReachedRole: piece->setReached(value.toBool()); break;
    case XposRole: piece->setXpos(value.toInt()); break;
    case YposRole: piece->setYpos(value.toInt()); break;
    }
    emit dataChanged(index, index, QVector<int>() << role);
    if (role==IndexRole) {
        emit dataChanged(index, index, QVector<int>() << role+4);
        emit dataChanged(index, index, QVector<int>() << role+5);
    }
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
    names[IndexRole] = "localindex";
    names[ColorRole] = "col";
    names[NameRole] = "name";
    names[ReachedRole] = "reached";
    names[XposRole]="xpos";
    names[YposRole]="ypos";
    return names;
}

void PieceModel::appendPiece(Piece *piece)
{
    m_pieces.push_back(piece);
}

void PieceModel::advancePiece(int index, int value)
{
    m_pieces[index]->advancePosition(value);
}


